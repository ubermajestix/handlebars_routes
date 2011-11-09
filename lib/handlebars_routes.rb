require "handlebars_routes/version"
require 'handlebars_routes/engine'

module HandlebarsRoutes
  def self.assets_path
    @assets_path ||= File.expand_path('../../vendor/assets/', __FILE__)
  end
end