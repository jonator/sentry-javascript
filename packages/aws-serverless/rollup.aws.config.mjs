import { makeNPMConfigVariants, makeBaseNPMConfig } from '@sentry-internal/rollup-utils';

// export default makeBundleConfigVariants(
//   makeBaseBundleConfig({
//     bundleType: 'node',
//     entrypoints: ['src/index.ts'],
//     licenseTitle: '@sentry/aws-serverless',
//     outputFileBase: () => 'aws',
//     external: ['require-in-the-middle']
//   })
// );


export default makeNPMConfigVariants(
  makeBaseNPMConfig({
    packageSpecificConfig: {
      output: {
        // set exports to 'named' or 'auto' so that rollup doesn't warn
        exports: 'named',
        // set preserveModules to false because we want to bundle everything into one file.
        preserveModules: false,

      },
    },
  }),
);
