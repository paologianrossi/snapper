
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "snapper/version"

Gem::Specification.new do |spec|
  spec.name          = "snapper"
  spec.version       = Snapper::VERSION
  spec.authors       = ["Paolo Gianrossi"]
  spec.email         = ["paolino.gianrossi@gmail.com"]

  spec.summary = %q{A collection of tiny classes to do OO Rails.}
  spec.description = %q{Snapper is a lightweight framework for better
  Ruby on Rails very heavily inspired by Trailblazer. It's mostly done
  so that I can know what's going on down below in my stack, and for
  educational purposes. You probably should use Trailblazer anyway.}
  spec.homepage = nil

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "awesome_print"

  spec.add_dependency "dry-validation"
end
