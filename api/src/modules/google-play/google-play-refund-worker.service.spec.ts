import { refundRetryDelay } from './google-play-refund-worker.service';

describe('Google Play refund worker retry schedule', () => {
  it('doubles the delay and caps it at 24 hours', () => {
    expect(refundRetryDelay(1)).toBe(300_000);
    expect(refundRetryDelay(2)).toBe(600_000);
    expect(refundRetryDelay(3)).toBe(1_200_000);
    expect(refundRetryDelay(31)).toBe(86_400_000);
  });
});
