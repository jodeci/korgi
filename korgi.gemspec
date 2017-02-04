$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "korgi/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "korgi"
  s.version     = Korgi::VERSION
  s.authors     = ["Tsehau Chao"]
  s.email       = ["jodeci@5xruby.tw"]
  s.homepage    = "https://github.com/jodeci/korgi"
  s.summary     = "Markdown filter for Rails resources"
  s.description = "Extends the Markdown syntax to allow quick generation of links to Rails resources."
  s.license     = "MIT"

  s.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0"
  s.add_dependency "activesupport", "~> 5.0"
  s.add_dependency "html-pipeline", "~> 2.4"
  s.add_dependency "carrierwave", "~> 1.0"
  s.add_dependency "mini_magick", "~> 4.6"
end
