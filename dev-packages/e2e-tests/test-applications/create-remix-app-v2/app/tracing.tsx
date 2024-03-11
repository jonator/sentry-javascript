import * as Sentry from '@sentry/remix';

Sentry.init({
  tracesSampleRate: 1.0, // Capture 100% of the transactions, reduce in production!
  environment: 'qa', // dynamic sampling bias to keep transactions
  dsn: process.env.E2E_TEST_DSN,
  // Performance Monitoring
});
