<p align="center">
  <a href="https://sentry.io/?utm_source=github&utm_medium=logo" target="_blank">
    <img src="https://sentry-brand.storage.googleapis.com/sentry-wordmark-dark-280x84.png" alt="Sentry" width="280" height="84">
  </a>
</p>

# Official Sentry SDK for AWS Lambda and AWS Serverless Environments

## Links

- [Official SDK Docs](https://docs.sentry.io/)
- [TypeDoc](http://getsentry.github.io/sentry-javascript/)

## General

This package is a wrapper around `@sentry/node`, with added functionality related to various Serverless solutions. All
methods available in `@sentry/node` can be imported from `@sentry/aws-serverless`.

Currently supported environment:

### AWS Lambda

To use this SDK, call `Sentry.init(options)` at the very beginning of your JavaScript file.

```javascript
import * as Sentry from '@sentry/aws-serverless';

Sentry.init({
  dsn: '__DSN__',
  // ...
});

// async (recommended)
exports.handler = Sentry.wrapHandler(async (event, context) => {
  throw new Error('oh, hello there!');
});

// sync
exports.handler = Sentry.wrapHandler((event, context, callback) => {
  throw new Error('oh, hello there!');
});
```

If you also want to trace performance of all the incoming requests and also outgoing AWS service requests, just set the `tracesSampleRate` option.

```javascript
import * as Sentry from '@sentry/aws-serverless';

Sentry.init({
  dsn: '__DSN__',
  tracesSampleRate: 1.0,
});
```

### AWS Lambda Layer

Another and much simpler way to integrate Sentry to your AWS Lambda function is to use an [AWS Lambda Layer](https://docs.aws.amazon.com/lambda/latest/dg/chapter-layers.html). See [docs](https://docs.sentry.io/platforms/node/guides/aws-lambda/layer/) for setup.
