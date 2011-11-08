require "handlebars_routes/version"
require 'handlebars_routes/engine'

module HandlebarsRoutes
  def self.assets_path
    puts "="*45
    puts 'omg!'
    puts "="*45
    @assets_path ||= File.expand_path('../../vendor/assets/', __FILE__)
  end
end