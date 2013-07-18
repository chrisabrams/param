# Cakefile

{exec} = require "child_process"

task 'build', 'Build to .js', ->
  exec 'coffee --output ./ --compile ./src/param.coffee',
  (err, output) ->
    throw err if err
    console.log output
