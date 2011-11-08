module HandlebarsRoutes
  class Engine < ::Rails::Engine
    initializer "handlebars.routes", :after => "sprockets.handlebars" do |app|
      next unless app.assets
      puts "="*45
      puts 'engine!'
      puts HandlebarsRoutes.assets_path.inspect
      puts "="*45
      app.assets.append_path HandlebarsRoutes.assets_path
      
    end
  
  
  end
end