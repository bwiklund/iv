![Logo](https://raw.github.com/bwiklund/iv/master/docs/logo.png)
iv.js
===
a tiny dependency injection library

__[iv.min.js](https://raw.github.com/bwiklund/iv/master/dist/iv.min.js)__ - 1.0 kB

__[iv.js](https://raw.github.com/bwiklund/iv/master/dist/iv.js)__ - 2.0 kB

Goals
===
To provide super simple dependency injection, in the style of angularjs and requirejs, but without the overhead of either. The minified script is less than 1kb. (998 bytes currently)

Usage
===
```coffeescript
# new module
mod = iv()

# our "service"
mod.define 'SomeService', -> 
  class
    request: -> "a service!"

# the entry point of our app. There is 
# nothing special about the name "Main"
mod.define 'FooApp', (SomeService) -> 
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

In the above example, note that there's nothing special about the two classes I'm declaring.

*Note that #define is reading the argument names of the function being passed in, and using that to determine what it depends on. If you are minifying code, or wish to have argument names that differ from their definition's names, read the section on minifying below.

Here is a terribly advanced example of using values as dependencies instead:

```coffeescript
mod = iv()
mod.define 'FavoriteAnimal', -> "GIRAFFES!"
val = mod.instance().resolve "FavoriteAnimal"
# val == "GIRAFFES!"
```

Of course, you can also return functions, like so:

```coffeescript
mod = iv()
mod.define 'AnimalImpersonator', -> -> "...what sound does a giraffe make?"
func = mod.instance().resolve "AnimalImpersonator"
# func() == "...what sound does a giraffe make?"
```

Note the funky "-> ->". The first function is the provider, which is called once when the dependency is resolved. It returns what's inside, which is another function in this case.

Notes
===
The library's source, and these examples, are written in coffeescript, but the library is compiled to JS, and has no dependency on coffeescript.

About minification
===
Minifying / uglifying you code can break the convenience of defining dependencies like this:
```coffeescript
mod.define 'Foo', (Arg1,Arg2) ->
```

This is because minification often changes argument names, which breaks the automatic parsing of them. The solution is to use three arguments, like so:
```coffeescript
mod.define 'Foo', ['Arg1',Arg2'], (Arg1,Arg2) ->
```

This is mostly how angularjs handles the situation, except that the function is a third argument to the definition, and not the final element in the array.

Node.js
===

Usage in nodejs is straightforward, although there isn't as much need for it here. For completeness:

```
npm install git://github.com/bwiklund/iv.git
```

```coffeescript
iv = require 'iv'

mod = iv()
mod.define 'AnimalImpersonator', -> -> "...what sound does a giraffe make?"
func = mod.instance().resolve "AnimalImpersonator"

console.log func()
```

Contributing
===
Any contributions are welcome.

To set up (assuming node is installed):
```
npm install
npm install -g grunt
```

To build:
```
grunt
```

To run tests:
```
npm test
```

Todo
===
- expand this documentation with more real world examples
