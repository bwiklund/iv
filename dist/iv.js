(function() {
  var Application, IV;

  IV = (function() {
    function IV() {
      this.members = {};
    }

    IV.prototype.define = function(name, deps, func) {
      if (deps.constructor === Function) {
        func = deps;
        deps = /\(.*\)/.exec(deps.toString())[0].slice(1, -1).replace(/\s/g, '');
        deps = deps.length === 0 ? [] : deps.split(',');
      }
      this.members[name] = {
        name: name,
        deps: deps,
        providerFunc: func,
        instance: null,
        startedProviding: false
      };
    };

    IV.prototype.instance = function() {
      var clone, k, name, provider, v, _ref;

      clone = {};
      _ref = this.members;
      for (name in _ref) {
        provider = _ref[name];
        clone[name] = {};
        for (k in provider) {
          v = provider[k];
          clone[name][k] = v;
        }
      }
      return new Application(clone);
    };

    return IV;

  })();

  Application = (function() {
    function Application(members) {
      this.members = members;
    }

    Application.prototype.resolve = function(name) {
      var args, dep, member;

      member = this.members[name];
      if (member.startedProviding && (member.instance == null)) {
        throw new Error("circular dependency on " + name);
      }
      member.startedProviding = true;
      if (member.instance == null) {
        args = (function() {
          var _i, _len, _ref, _results;

          _ref = member.deps;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            dep = _ref[_i];
            _results.push(this.resolve(dep));
          }
          return _results;
        }).call(this);
        member.instance = member.providerFunc.apply({}, args);
      }
      return member.instance;
    };

    return Application;

  })();

  if (typeof module !== "undefined" && module !== null) {
    module.exports = function() {
      return new IV;
    };
  }

  if (typeof window !== "undefined" && window !== null) {
    window.iv = function() {
      return new IV;
    };
  }

}).call(this);
