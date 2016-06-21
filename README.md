# meshblu-connector-schema-generator

[![Dependency status](http://img.shields.io/david/octoblu/meshblu-connector-schema-generator.svg?style=flat)](https://david-dm.org/octoblu/meshblu-connector-schema-generator)
[![devDependency Status](http://img.shields.io/david/dev/octoblu/meshblu-connector-schema-generator.svg?style=flat)](https://david-dm.org/octoblu/meshblu-connector-schema-generator#info=devDependencies)
[![Build Status](http://img.shields.io/travis/octoblu/meshblu-connector-schema-generator.svg?style=flat&branch=master)](https://travis-ci.org/octoblu/meshblu-connector-schema-generator)
[![Slack Status](http://community-slack.octoblu.com/badge.svg)](http://community-slack.octoblu.com)

[![NPM](https://nodei.co/npm/meshblu-connector-schema-generator.svg?style=flat)](https://npmjs.org/package/meshblu-connector-schema-generator)

A component of [Meshblu Connectors](https://meshblu-connectors.readme.io). Click [here](https://meshblu-connectors.readme.io/docs/connector-schema-generator) to view the component documentation.

## Getting Started

### Installation

In the connector project, follow these steps:

1 - Install the library

```bash
npm install --save meshblu-connector-schema-generator
```

2 - Add to the `start` script to your package.json

```js
{
  //...
  "scripts": {
    "generate:schema": "meshblu-connector-schema-generator > ./schemas.json"
  }
  //...
}
```
