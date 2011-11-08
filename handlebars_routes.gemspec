# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "handlebars_routes/version"

Gem::Specification.new do |s|
  s.name        = "handlebars_routes"
  s.version     = HandlebarsRoutes::VERSION
  s.authors     = ["Tyler Montgomery"]
  s.email       = ["tyler.a.montgomery@gmail.com"]
  s.homepage    = "https://github.com/ubermajestix/handlebars_routes"
  s.summary     = "Rails routes in your javascripts, link_to and route helper for Handlebars"
  s.description = "Rails routes in your javascripts, link_to and route helper for Handlebars"

  s.rubyforge_project = "handlebars_routes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "execjs", "~> 1.2.9"
  s.add_runtime_dependency "handlebars_assets", "~> 0.1.3"

end
