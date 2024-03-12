#!/usr/bin/env bash
#
# Builds and deploys the Sentry AWS Lambda layer (including the Sentry SDK and the Sentry Lambda Extension)
#
# The currently checked out version of the SDK in your local directory is used.
# The latest version of the Lambda Extension is fetched from the Sentry Release Registry.
#
# Note: While we normally try to write all of our scripts in TS, this is in bash because it's meant to exactly mirror
# what the lambda-zipping GHA is doing (see https://github.com/getsentry/action-build-aws-lambda-extension)

set -euo pipefail

# Remove old distribution directories and zip files.
echo "Preparing local directories for new build..."
rm -rf dist-serverless/
rm -rf ./packages/aws-serverless/build
rm -rf ./packages/aws-serverless/node_modules

# Creating Lambda layer
echo "Creating Lambda layer in ./packages/aws-serverless/build/aws/dist-serverless..."
cd packages/aws-serverless
yarn build
echo "Done creating Lambda layer in ./packages/aws-serverless/build/aws/dist-serverless."

# Deploying zipped Lambda layer to AWS
ZIP=$(ls build/aws/dist-serverless | grep sentry-aws-serverless | head -n 1)
echo "Deploying zipped Lambda layer $ZIP to AWS..."

aws lambda publish-layer-version \
  --layer-name "SentryAwsServerlessSDKv8-local-dev" \
  --region "eu-central-1" \
  --zip-file "fileb://build/aws/dist-serverless/$ZIP" \
  --description "Local test build of SentryAwsServerlessSDKv8 (can be deleted)" \
  --compatible-runtimes nodejs14.x nodejs16.x nodejs18.x nodejs20.x

echo "Done deploying zipped Lambda layer to AWS as 'SentryAwsServerlessSDKv8-local-dev'."

echo "All done. Have a nice day!"
