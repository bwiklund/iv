# module class
class IV
  
  constructor: ->
    @members = {}

  # overloaded
  #
  # can be called like #define 'name', ['dep1','dep2'], (dep1, dep2) -> 
  #
  # or like #define 'name', (dep1,dep2) ->
  #
  # the first version is to defeat minification. the second is to be as
  # concise as possible for convenience, if you're not minifying
  define: (name, deps, func) ->
    # use reflection if possible
    if deps.constructor == Function
      func = deps
      # golf
      deps = /\(.*\)/.exec(deps.toString())[0].slice(1,-1).replace(/\s/g,'')
      # get around the fact that "".split(",") => [''], and not the [] that we want
      deps = if deps.length == 0 then [] else deps.split(',')

    @members[name] =
      name: name
      deps: deps
      providerFunc: func
      instance: null
      startedProviding: false
    return # force coffeescript to omit return

  instance: ->
    # quick handrolled deep copy, didn't want to depend on any libraries for this
    clone = {}
    for name,provider of @members
      clone[name] = {}
      for k,v of provider
        clone[name][k] = v

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


# export to browser and nodejs alike
module?.exports = -> new IV
window?.iv = IV
