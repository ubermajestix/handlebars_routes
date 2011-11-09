module HandlebarsRoutes
  class Engine < ::Rails::Engine
    initializer "handlebars.routes", :after => "sprockets.handlebars" do |app|
      next unless app.assets
      app.assets.append_path HandlebarsRoutes.assets_path
    end
  
  
  end
end