# required nodejs modules
execFile = require( 'child_process' ).execFile
path = require 'path'

# DBFProxy class definition
class DBFProxy
  constructor : ( @_path = undefined ) ->
    throw 'base path is required' if not @_path
    @_binary = path.join __dirname, '..', 'bin', 'dbf.exe'

  query : ( query, cb, bufferSize = 5000 ) ->
    command = [
      '--path'
      @getPath()
      '--query'
      query
    ]

    execFile @_binary, command, { maxBuffer: 1024 * bufferSize }, ( err, stdout, stderr ) ->
      if stderr.length is 0 and err
        return cb err, null
      if err
        return cb stderr, null
      try
        return cb null, JSON.parse stdout
      catch e
        cb e, stdout

  # define getters and setters
  getPath : -> @_path
  setPath : ( @_path ) ->

module.exports = DBFProxy
