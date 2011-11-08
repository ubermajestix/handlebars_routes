# Builds a link using the route helper below
# text - String
# route_name - String used to lookup route in the rails_routes global object
# 
Handlebars.registerHelper 'link_to', (text, route_name) ->
  href = Handlebars.helpers['router'](route_name, @)
  template = _.template("<a href='{{href}}'>{{text}}</a>")
  template(text: text, href: href)

# Returns what it returns.
# Grab a named route from the global rails_routes object
# rails_routes are mustached, so we'll try to match the object's attributes
# to the attribute names in the route. We'll even recurse into the object
# if needed.
#
# route_name  - String to lookup route in the rails_routes global object
# object      - (optional) Object to feed the rails_routes attributes.
#               If you use route helper directly and don't pass object it will
#               be inferred from the current Handlebars context               
# Example:
# object = {id: 1, title: 'boom', company_id: 5 }
# route = /companies/:company_id/resources/:id 
# # => /companies/5/resources/1
# 
# Example:
# object = {id: 1, title: 'boom', company: { id: 2 }}
# route = /companies/:company_id/resources/:id 
# # => /companies/2/resources/1
#
Handlebars.registerHelper 'router', (route_name, object) ->
  object or= @
  route = rails_routes[route_name]
  if route
    attrs = []
    # extract the attributes from the mustaches in the route
    mustache = /\{\{(.+?)\}\}/g
    route.replace(mustache, (match, code) -> attrs.push code)
    attr_hash = {}
    # build a hash of the attrs we found with the replace function
    # build an array to traverse if the attr has an underscore in it
    # we'll look for nested objects if we don't find a value in the object
    # for the underscored attr.
    _.each attrs, (attr)->
      attr_hash[attr] or= [attr]
      if attr.match(/_/)
         attr_hash[attr].push attr.split("_")
    # for each key in attr_hash, look for the value for that key in object
    # when you find a value, replace the array with the object's value
    # if you don't find anything, raise an error (somehow?)
    # then use the new attr_hash and throw it at _.template
    traverse = (obj, path) -> 
      while path.length > 0
        node = path.shift()
        if typeof(obj[node]) == "object"
          return traverse(obj[node], path)
        else
          return obj[node]
    _.each _.keys(attr_hash), (key) ->
      if object[key]?
        attr_hash[key] = object[key]
      else
        attr_hash[key] = traverse(object, _.clone(attr_hash[key][1]))
    
    _.template(route)(attr_hash)

   
