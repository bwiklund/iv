assert = require 'assert'
iv = require('../iv')

suite "iv", ->

  test "exists", ->
    assert.notEqual iv, undefined

  test "hello world example", ->
    mod = iv()
    mod.define 'foo', [], -> 'bar'
    mod.define 'main', ['foo'], (foo) -> foo

    app = mod.instance()
    main = app.resolve 'main'

    assert.equal main, 'bar'

  test "fails on circular dependencies", ->
    mod = iv()
    mod.define 'foo', ['bar'], -> 'bar'
    mod.define 'bar', ['foo'], (foo) -> foo

    app = mod.instance()
    try
      main = app.resolve 'foo'
    catch e
      exception = e

    assert.equal exception.constructor, Error