_    = require 'lodash'
fs   = require 'fs'
path = require 'path'

class JobSchemaParser
  constructor: ({@connectorPath}) ->
    throw new Error 'JobSchemaParser requires connectorPath' unless @connectorPath?
    @jobs = @_getJobs()
    @configs = @_getConfigs()

  configSchema: (callback) =>
    callback null, @_configSchemaFromConfigs @configs

  formSchema: (callback) =>
    schema = _.merge @_formSchemaFromJobs(@jobs), @_formSchemaFromConfigs(@configs)
    callback null, schema

  messageSchema: (callback) =>
    callback null, @_messageSchemaFromJobs @jobs

  responseSchema: (callback) =>
    callback null, @_responseSchemaFromJobs @jobs

  _configSchemaFromConfig: (config, key) =>
    schema = _.cloneDeep config.config
    _.set schema, 'x-form-schema.angular', "configure.#{key}.angular"
    return schema

  _configSchemaFromConfigs: (configs) =>
    _.mapValues configs, @_configSchemaFromConfig

  _formSchemaFromJobs: (jobs) =>
    return {
      message: _.mapValues jobs, 'form'
    }

  _formSchemaFromConfigs: (configs) =>
    return {
      configure: _.mapValues configs, 'form'
    }

  _generateMessageMetadata: (jobType) =>
    return {
      type: 'object'
      required: ['jobType']
      properties:
        jobType:
          type: 'string'
          enum: [jobType]
          default: jobType
        respondTo: {}
    }

  _generateResponseMetadata: =>
    return {
      type: 'object'
      required: ['status', 'code']
      properties:
        status:
          type: 'string'
        code:
          type: 'integer'
    }

  _getConfigs: =>
    dirnames = fs.readdirSync path.join(@connectorPath, 'configs')
    configs = {}
    _.each dirnames, (dirname) =>
      key = _.upperFirst _.camelCase dirname
      dir = path.join @connectorPath, 'configs', dirname
      configs[key] = require dir
    return configs

  _getJobs: =>
    dirnames = fs.readdirSync path.join(@connectorPath, 'jobs')
    jobs = {}
    _.each dirnames, (dirname) =>
      key = _.upperFirst _.camelCase dirname
      dir = path.join @connectorPath, 'jobs', dirname
      jobs[key] = require dir
    return jobs

  _messageSchemaFromJob: (job, key) =>
    message = _.cloneDeep job.message
    _.set message, 'x-form-schema.angular', "message.#{key}.angular"
    _.set message, 'x-response-schema', "#{key}"
    _.set message, 'properties.metadata', @_generateMessageMetadata(key)
    message.required = _.union ['metadata'], message.required
    return message

  _messageSchemaFromJobs: (jobs) =>
    _.mapValues jobs, @_messageSchemaFromJob

  _responseSchemaFromJob: (job) =>
    response = _.cloneDeep job.response
    _.set response, 'properties.metadata', @_generateResponseMetadata()
    return response

  _responseSchemaFromJobs: (jobs) =>
    _.mapValues jobs, @_responseSchemaFromJob

module.exports = JobSchemaParser
