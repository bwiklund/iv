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


  test "real world-ish OOP example", ->

    # new module
    mod = iv()

    # a 'service'
    mod.define 'SomeService', [], -> 
      class
        request: -> "a service!"

    # the entry point of our app. There is 
    # nothing special about the name "Main"
    mod.define 'FooApp', ['SomeService'], (SomeService) -> 
      class
        constructor: ->
          @service = new SomeService()

    # choosing an entry point for the app
    FooApp = mod.instance().resolve 'FooApp'
    main = new FooApp()

    assert.equal main.service.request(), "a service!"

