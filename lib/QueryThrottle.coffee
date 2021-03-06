_ = require 'lodash'
debug = require('debug')('meshblu:QueryThrottle')

class QueryThrottle
  constructor: ->
    @queryThrottle = require('./getThrottles').query

  throttle: (id, onThrottleCallback=_.noop, next=_.noop) =>
    @queryThrottle.rateLimit id, (error, isLimited) =>
      debug 'rateLimit', id, isLimited

      return onThrottleCallback error if error?
      return onThrottleCallback new Error('request exceeds rate limit') if isLimited

      next()

module.exports = QueryThrottle
