# This code was taken from jQuery.param and a few other methods and then simplified to work without jQuery dependency.

r20             = /%20/g
rbracket        = /\[\]$/
rCRLF           = /\r?\n/g
rsubmitterTypes = /^(?:submit|button|image|reset|file)$/i
rsubmittable    = /^(?:input|select|textarea|keygen)/i

buildParams = (prefix, obj, add) ->

  name = undefined

  if obj instanceof Array
    
    # Serialize array item.
    obj.forEach (v, i) ->
      if rbracket.test(prefix)
        
        # Treat each array item as a scalar.
        add prefix, v
      else
        
        # Item is non-scalar (array or object), encode its numeric index.
        buildParams prefix + "[" + ((if typeof v is "object" then i else "")) + "]", v, add

  else if typeof obj is "object"
    
    # Serialize object item.
    for name of obj
      buildParams prefix + "[" + name + "]", obj[name], add

  else
    
    # Serialize scalar item.
    add prefix, obj

module.exports = param = (a) ->

  prefix = undefined
  s = []

  add = (key, value) ->
    
    if typeof value is 'function'
      value = value()

    else

      if not value?
        value = ""

      else
        value = value

    s[s.length] = encodeURIComponent(key) + "=" + encodeURIComponent(value)

  if a instanceof Array

    a.forEach () ->
      add @name, @value

  else

    for prefix of a
      buildParams prefix, a[prefix], add

  s.join("&").replace r20, "+"

if typeof window isnt 'undefined'
  window.param = param
