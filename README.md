iv
===
a tiny dependency injection library

Goals
===
to provide super simple dependency injection, in the style of angularjs and requirejs

Usage
===
```coffeescript
mod = iv()
    mod.define 'foo', [], -> 'bar'
    mod.define 'main', ['foo'], (foo) -> foo

    app = mod.instance()
    main = app.resolve 'main'

    assert.equal main, 'bar'
```

wip