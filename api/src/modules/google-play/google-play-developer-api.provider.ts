import {
  BadRequestException,
  Injectable,
  ServiceUnavailableException,
} from '@nestjs/common';
import { importPKCS8, SignJWT } from 'jose';

const TOKEN_URL = 'https://oauth2.googleapis.com/token';
const API_ROOT =
  'https://androidpublisher.googleapis.com/androidpublisher/v3/applications';
const ANDROID_PUBLISHER_SCOPE =
  'https://www.googleapis.com/auth/androidpublisher';

interface ServiceAccount {
  client_email: string;
  private_key: string;
}

export interface GooglePlayProductPurchaseV2 {
  orderId?: string;
  purchaseCompletionTime?: string;
  obfuscatedExternalAccountId?: string;
  acknowledgementState?: string;
  purchaseStateContext?: { purchaseState?: string };
  productLineItem?: Array<{
    productId?: string;
    productOfferDetails?: {
      quantity?: number;
      refundableQuantity?: number;
      consumptionState?: string;
    };
  }>;
}

export interface GooglePlayOrder {
  orderId?: string;
  purchaseToken?: string;
  state?: string;
  createTime?: string;
  lineItems?: Array<{
    productId?: string;
    total?: { currencyCode?: string; units?: string; nanos?: number };
    oneTimePurchaseDetails?: { quantity?: number };
  }>;
  total?: { currencyCode?: string; units?: string; nanos?: number };
  developerRevenueInBuyerCurrency?: {
    currencyCode?: string;
    units?: string;
    nanos?: number;
  };
}

interface OAuthTokenResponse {
  access_token?: string;
  expires_in?: number;
  token_type?: string;
}

@Injectable()
export class GooglePlayDeveloperApiProvider {
  private cachedAccessToken: { value: string; expiresAt: number } | null = null;
  private tokenRequest: Promise<string> | null = null;

  isConfigured(): boolean {
    const account = this.serviceAccount();
    const packageName =
      process.env.GOOGLE_PLAY_PACKAGE_NAME?.trim() || 'so.kyron.app';
    return (
      !!account &&
      /^[A-Za-z][A-Za-z0-9_]*(?:\\.[A-Za-z][A-Za-z0-9_]*)+$/.test(packageName)
    );
  }

  async getProductPurchase(
    token: string,
  ): Promise<GooglePlayProductPurchaseV2> {
    const url = `${API_ROOT}/${encodeURIComponent(this.packageName())}/purchases/productsv2/tokens/${encodeURIComponent(token)}`;
    return this.request<GooglePlayProductPurchaseV2>(url, 'GET', true);
  }

  async getOrder(orderId: string): Promise<GooglePlayOrder> {
    const url = `${API_ROOT}/${encodeURIComponent(this.packageName())}/orders/${encodeURIComponent(orderId)}`;
    return this.request<GooglePlayOrder>(url, 'GET', true);
  }

  async consume(productId: string, token: string): Promise<void> {
    const url = `${API_ROOT}/${encodeURIComponent(this.packageName())}/purchases/products/${encodeURIComponent(productId)}/tokens/${encodeURIComponent(token)}:consume`;
    await this.request<void>(url, 'POST', false);
  }

  private async request<T>(
    url: string,
    method: 'GET' | 'POST',
    expectsJson: boolean,
  ): Promise<T> {
    const accessToken = await this.accessToken();
    let response: Response;
    try {
      response = await fetch(url, {
        method,
        headers: {
          Authorization: `Bearer ${accessToken}`,
          Accept: 'application/json',
        },
        signal: AbortSignal.timeout(10_000),
      });
    } catch {
      throw new ServiceUnavailableException(
        'Google Play could not be reached. The purchase remains available for retry.',
      );
    }

    if (response.status === 404 || response.status === 400) {
      throw new BadRequestException(
        'Google Play could not verify this purchase.',
      );
    }
    if (response.status === 401 || response.status === 403) {
      throw new ServiceUnavailableException(
        'Google Play credentials or permissions are not configured correctly.',
      );
    }
    if (response.status === 429 || response.status >= 500) {
      throw new ServiceUnavailableException(
        'Google Play is temporarily unavailable. The purchase can be retried safely.',
      );
    }
    if (!response.ok) {
      throw new ServiceUnavailableException(
        'Google Play returned an unexpected response.',
      );
    }
    if (!expectsJson) return undefined as T;

    try {
      return (await response.json()) as T;
    } catch {
      throw new ServiceUnavailableException(
        'Google Play returned an unreadable response.',
      );
    }
  }

  private async accessToken(): Promise<string> {
    const cached = this.cachedAccessToken;
    if (cached && cached.expiresAt > Date.now() + 60_000) {
      return cached.value;
    }
    if (this.tokenRequest) return this.tokenRequest;

    this.tokenRequest = this.createAccessToken();
    try {
      return await this.tokenRequest;
    } finally {
      this.tokenRequest = null;
    }
  }

  private async createAccessToken(): Promise<string> {
    const account = this.serviceAccount();
    if (!account) {
      throw new ServiceUnavailableException(
        'Google Play purchase verification is not configured.',
      );
    }

    try {
      const key = await importPKCS8(account.private_key, 'RS256');
      const now = Math.floor(Date.now() / 1000);
      const assertion = await new SignJWT({
        scope: ANDROID_PUBLISHER_SCOPE,
      })
        .setProtectedHeader({ alg: 'RS256', typ: 'JWT' })
        .setIssuer(account.client_email)
        .setSubject(account.client_email)
        .setAudience(TOKEN_URL)
        .setIssuedAt(now)
        .setExpirationTime(now + 3600)
        .sign(key);

      const response = await fetch(TOKEN_URL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
          grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
          assertion,
        }),
        signal: AbortSignal.timeout(10_000),
      });
      if (!response.ok) {
        throw new Error('OAuth token exchange failed.');
      }

      const token = (await response.json()) as OAuthTokenResponse;
      const expiresIn = token.expires_in;
      if (
        !token.access_token ||
        typeof expiresIn !== 'number' ||
        !Number.isSafeInteger(expiresIn) ||
        expiresIn <= 0
      ) {
        throw new Error('OAuth token response was invalid.');
      }

      this.cachedAccessToken = {
        value: token.access_token,
        expiresAt: Date.now() + expiresIn * 1000,
      };
      return token.access_token;
    } catch {
      throw new ServiceUnavailableException(
        'Google Play service-account authentication failed.',
      );
    }
  }

  private packageName(): string {
    const value = process.env.GOOGLE_PLAY_PACKAGE_NAME?.trim();
    if (!value || value.length > 255) {
      throw new ServiceUnavailableException(
        'Google Play package name is not configured.',
      );
    }
    return value;
  }

  private serviceAccount(): ServiceAccount | null {
    const raw = process.env.GOOGLE_PLAY_SERVICE_ACCOUNT_JSON;
    if (!raw) return null;
    try {
      const value = JSON.parse(raw) as Partial<ServiceAccount>;
      if (
        typeof value.client_email !== 'string' ||
        !/^[^\s@]+@[^\s@]+\.iam\.gserviceaccount\.com$/.test(
          value.client_email,
        ) ||
        typeof value.private_key !== 'string' ||
        !value.private_key.includes('BEGIN PRIVATE KEY')
      ) {
        return null;
      }
      return {
        client_email: value.client_email,
        private_key: value.private_key.replace(/\\n/g, '\n'),
      };
    } catch {
      return null;
    }
  }
}
