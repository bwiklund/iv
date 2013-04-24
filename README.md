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
# new module
mod = iv()

# our "service"
mod.define 'SomeService', [], -> 
  class
    request: -> "a service!"

# the entry point of our app. There is 
# nothing special about the name "Main"
mod.define 'FooApp', ['SomeService'], (SomeService) -> 
  class
    constructor: ->
      @service = new SomeService()

# we want to start our app with and instance of FooApp,
# and we do so here. Note there is no special "main" 
# dependency, you can #resolve whatever you want,
# whenever you want
FooApp = mod.instance().resolve 'FooApp'
main = new FooApp()
```

TODO
===
- use reflection to infer dependencies from function argument names, like angularjs
- expand this documentation with more real world examples