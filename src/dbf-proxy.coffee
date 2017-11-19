# required nodejs modules
exec = require( 'child_process' ).exec
path = require 'path'

# DBFProxy class definition
class DBFProxy
  constructor : ( @_path = undefined ) ->
    throw 'base path is required' if not @_path
    @_binary = path.join __dirname, '..', 'bin', 'dbf.exe'

  query : ( query, cb, bufferSize = 5000 ) -> 
    query = '"' + query + '"'
    command = [
      @_binary
      '--path'
      @getPath()
      '--query'
      query
    ]

    exec command.join( ' ' ), { maxBuffer: 1024 * bufferSize }, ( err, stdout, stderr ) ->
      if stderr.length is 0
        return cb err, null
      else
        return cb stderr, null

      try
        return cb null, JSON.parse stdout
      catch e
        cb e, stdout

  # define getters and setters
  getPath : -> @_path
  setPath : ( @_path ) ->

module.exports = DBFProxy

