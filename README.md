# node-dbf-proxy
dbf file reader and writer proxy to c# executable

This package only is tested on windows platforms.

## install

`> npm install dbf-proxy`

## usage

```coffeescript
DBF  = require 'dbf-proxy'
path = require 'path'

db = new DBF path.join 'c:', 'data'

db.query 'SELECT * FROM user', ( err, data ) ->
  console.error err if err
  console.log data
```

`dbf-proxy` constructor receives as argument the path where dbf files are stored in. In this case my data is stored on `c:/data`, for this example when query is executed it consult the file `c:/data/user.dbf`

## query

`db.query( sql, callback, bufferSize )`

* sql: sql statement to be executed (INSERT, SELECT, DELETE, UPDATE, JOIN, etc).
* callback: a function that receives two arguments `( err, data )`, `err` for errors and `data` for results, data is null if error is ocurred.
* bufferSize: by default is 5000, if you need to perform a big query you need more buffer, then set the buffer memory that you need in the third argument. if you need less buffer memory then set this value less than 5000.
