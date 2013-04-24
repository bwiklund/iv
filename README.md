iv
===
a tiny dependency injection library

(Minified: 877 bytes)[https://raw.github.com/bwiklund/iv/master/dist/iv.min.js]
(Minified: 877 bytes)[https://raw.github.com/bwiklund/iv/master/dist/iv.min.js]

Goals
===
To provide super simple dependency injection, in the style of angularjs and requirejs, but without the overhead of either. The minified script is less than 1kb.

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

TODO
===
- use reflection to infer dependencies from function argument names, like angularjs
- expand this documentation with more real world examples