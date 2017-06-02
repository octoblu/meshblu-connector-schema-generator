#!/usr/bin/env node
'use strict';
var SchemaGenerator, schemaGenerator;

SchemaGenerator = require('./');
schemaGenerator = new SchemaGenerator({argv: process.argv});
schemaGenerator.run();
