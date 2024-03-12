import { registerInstrumentations } from '@opentelemetry/instrumentation';
import { defineIntegration } from '@sentry/core';
import { FetchInstrumentation } from '@vercel/otel';

export const vercelFetchIntegration = defineIntegration(() => {
  return {
    name: 'VercelFetchIntegration',
    setupOnce() {
      registerInstrumentations({ instrumentations: [new FetchInstrumentation({ enabled: true })] });
    },
  };
});
