# required nodejs modules
exec = require( 'child_process' ).exec
path = require 'path'

# DBFProxy class definition
class DBFProxy
  constructor : ( @_path = undefined ) ->
    throw 'base path is required' if not @_path
    @_binary = path.join __dirname, '..', 'bin', 'dbf.exe'

  query : ( query, cb ) -> 
    query = '"' + query + '"'
    command = [
      @_binary
      '--path'
      @getPath()
      '--query'
      query
    ]

    exec command.join( ' ' ), ( err, stdout, stderr ) ->
      return cb stderr, null if err
      return cb null, JSON.parse stdout

  # define getters and setters
  getPath : -> @_path
  setPath : ( @_path ) ->

module.exports = DBFProxy

