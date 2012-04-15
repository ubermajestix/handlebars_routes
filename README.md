Handlebars Routes
=================

Installing
----------

Bundle it

    gem 'handlebars_routes', '~> 0.0.1'

Sprockets require it (in app/assets/javascripts/application.(js|coffee) for example):

    //= handlebars_routes

The `link_to` helper uses [underscore.js](https://github.com/rweng/underscore-rails) templating and assumes you have put it into "mustache mode"

    # Setup underscore's templating to use Mustache style templates
    _.templateSettings =
      interpolate: /\{\{(.+?)\}\}/g


What it does
------------
Its really annoying not to have all your Rails routes on the client side especially when you're doing Javascript templating.  This gem aims to fix that by dumping your rails routes into a `rails_routes` object in javascript.

I've added my Handlebars Helpers `router` and `link_to`. The `link_to` helper uses the `router` helper to create links in Handlebars templates very much like creating links in Rails templates.

The `router` will traverse your object looking for the right attributes to put into the route. You could also use these routes in Backbone models' urls, haven't tried it yet but its a thought.

Examples are probably better eh?
--------------------------------

Given the Rails routes:

    resources :items do
      resources :products
    end

Given the data (a Backbone like object):

    item = { attributes: {
               id: 42, 
               product: {id:24, title: 'Pugs not Drugs'}, 
               item_code: "PUGS", 
               created_at:'11/11/2011'      
              }
           }

And the template item/show.jst.hbs (notice the **triple-stache** around link_to).
`"item_product"` is the route that Rails provided. The list of routes
are stored in the `rails_routes` global javascript object. Take a look at
it in Inspector to find specific routes. 

    <tr>
      {{#attributes}}
        <td>{{{link_to product.title "item_product"}}}</td>
        <td> {{item_code}}  </td>
        <td> {{created_at}}</td>
      {{/attributes}}
    </tr>

And this coffeescript Backbone View:

    class ItemView extends Backbone.View
      # ...

      render: =>
        $(@el).prepend JST['item/show'] @model

      # ...
    end

This awesome looking html will be produced!!!

    <tr>
      <td><a href="/items/42/products/24">Pugs not Drugs</a</td>
      <td>PUGS</td>
      <td>11/11/2011</td>
    </tr>

