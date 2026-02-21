// In profile_wallet.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// Add this AppButton if you don't have it yet
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isOutlined;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isOutlined = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.accent,
          side: const BorderSide(color: AppTheme.accent),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: isLoading 
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(label),
      );
    }

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.accent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(label),
    );
  }
}

class ProfileWallet extends StatelessWidget {
  final String did;
  final int kyronPoints;
  final VoidCallback onTopUp;
  final VoidCallback onWithdraw;

  const ProfileWallet({
    super.key,
    required this.did,
    required this.kyronPoints,
    required this.onTopUp,
    required this.onWithdraw,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface.withOpacity(0.1), // Fixed
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.textSecondary.withOpacity(0.2), // Fixed
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DID badge
          Row(
            children: [
              const Icon(Icons.qr_code, color: AppTheme.accent, size: 20),
              const SizedBox(width: 8),
              Text(
                'DID: $did',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8), // Fixed
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // KP with buttons
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$kyronPoints KP',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Kyron Points',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6), // Fixed
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 36,
                child: AppButton(
                  label: 'Top Up',
                  onTap: onTopUp,
                  isOutlined: false,
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 36,
                child: AppButton(
                  label: 'Withdraw',
                  onTap: onWithdraw,
                  isOutlined: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}