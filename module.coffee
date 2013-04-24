
class Module
  
  constructor: ->
    @members = {}

  define: (name, deps, func) ->
    @members[name] =
      name: name
      deps: deps
      provider: func
      instance: null
      startedProviding: false

  resolve: (name) ->
    member = @members[name]

    throw new Error( "circular dependency on #{name}" ) if member.startedProviding
    member.startedProviding = true

    if !member.instance?
      args = ( @resolve(dep) for dep in member.deps )
      member.instance = member.provider.apply {}, args

    member.instance



mod = new Module
mod.define 'foo',  [], -> 'bar'
mod.define 'main', ['foo'], (foo) -> foo



app = mod.resolve 'main'

console.log app