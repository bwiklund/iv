# a collection of dependencies
class Module
  
  constructor: ->
    @members = {}

  define: (name, deps, func) ->
    @members[name] =
      name: name
      deps: deps
      providerFunc: func
      instance: null
      startedProviding: false

  instance: ->
    # quick handrolled deep copy, didn't want to depend on any libraries for this
    clone = {}
    for name,provider of @members
      clone[name] = {}
      for k,v of provider
        clone[name][k] = v

    console.log clone
    new Application clone



# an instance of a module. handles actually resolving and instantiating deps
class Application

  constructor: (@members) ->

  resolve: (name) ->
    member = @members[name]

    throw new Error( "circular dependency on #{name}" ) if member.startedProviding
    member.startedProviding = true

    if !member.instance?
      args = ( @resolve(dep) for dep in member.deps )
      member.instance = member.providerFunc.apply {}, args

    member.instance



mod = new Module
mod.define 'foo', [], -> 'bar'
mod.define 'main', ['foo'], (foo) -> foo

app = mod.instance()
main = app.resolve 'main'

console.log main