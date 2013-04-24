# module class
class IV
  
  constructor: ->
    @members = {}

  # overloaded
  #
  # called as #define 'name', ['dep1','dep2'], (dep1, dep2) -> 
  #
  # or as #define 'name', (dep1,dep2) ->
  #
  # the first version is to defeat minification. the second is to be as
  # concise as possible for convenience, if you're not minifying
  define: (name, deps, func) ->
    # use reflection if possible
    if deps.constructor == Function
      func = deps
      # get the argument names from the function.toString() output
      deps = /\(.*\)/.exec(deps.toString())[0]
                     .slice(1,-1)
                     .replace(/\s/g,'')
      # get around the fact that "".split(",") => [''], and not the [] that we want
      deps = if deps.length == 0 then [] else deps.split(',')

    # startedProviding and finishedProviding seem superfluous,
    # why not just see if there's an instance yet? But the first
    # is to detect circular dependencies whil resolving them, and
    # the second is so that a dependency could, conceivably,
    # resolve to a falsey value, or undefined
    @members[name] =
      name: name
      deps: deps
      providerFunc: func
      instance: null
      startedProviding: false
      finishedProviding: false
    # force coffeescript to omit return
    return 

  # copy the list of dependencies, and create an Application instance with them
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

  # recursively resolve whatever dependencies this requires
  resolve: (name) ->
    member = @members[name]

    # spending those precious bytes on a readable exception
    if member.startedProviding && !member.finishedProviding
      throw new Error "circular dependency on #{name}"
    member.startedProviding = true

    if !member.finishedProviding
      args = ( @resolve(dep) for dep in member.deps )
      member.instance = member.providerFunc.apply {}, args
      member.finishedProviding = true

    member.instance


# export to browser and nodejs alike
module?.exports = -> new IV
window?.iv = -> new IV
