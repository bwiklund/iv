![Logo](https://raw.github.com/bwiklund/iv/master/docs/logo.png)
iv
===
a tiny dependency injection library

__[iv.min.js](https://raw.github.com/bwiklund/iv/master/dist/iv.min.js)__ - 0.9 kB

__[iv.js](https://raw.github.com/bwiklund/iv/master/dist/iv.js)__ - 1.8 kB

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

In the above example, note that there's nothing special about the two classes I'm declaring.

Here is a terribly advanced example of using values as dependencies instead:

```coffeescript
mod = iv()
mod.define 'FavoriteAnimal', [], -> "GIRAFFES!"
val = mod.instance().resolve "FavoriteAnimal"
# val == "GIRAFFES!"
```

Of course, you can also return functions, like so:

```coffeescript
mod = iv()
mod.define 'AnimalImpersonator', [], -> -> "...what sound does a giraffe make?"
func = mod.instance().resolve "AnimalImpersonator"
# func() == "...what sound does a giraffe make?"
```

Note the funky "-> ->". The first function is the provider, which is called once when the dependency is resolved. It returns what's inside, which is another function in this case.

Notes:
===
The library's source, and these examples, are written in coffeescript, but the library is compiled to JS, and has no dependency of coffeescript.

Node.js
===

Usage in nodejs is straightforward, although there isn't as much need for it here. For completeness:

```
npm install git://github.com/bwiklund/iv.git
```

```coffeescript
iv = require 'iv'

mod = iv()
mod.define 'AnimalImpersonator', [], -> -> "...what sound does a giraffe make?"
func = mod.instance().resolve "AnimalImpersonator"

console.log func()
```

Contributing:
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

Todo:
===
- use reflection to infer dependencies from function argument names, like angularjs
- expand this documentation with more real world examples
