# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "exception_resource/version"

Gem::Specification.new do |s|
  s.name        = "exception_resource"
  s.version     = ExceptionResource::VERSION
  s.authors     = ["Rafael Souza"]
  s.email       = ["me@rafaelss.com"]
  s.homepage    = "http://github.com/rafaelss/exception_resource"
  s.summary     = %q{Save your exceptions}
  s.description = %q{Save your exceptions}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "exception-hashify", "~> 0.0.1"
  s.add_development_dependency "rspec", "~> 2.6.0"
  s.add_development_dependency "artifice", "~> 0.6"
  s.add_development_dependency "rack", ">= 1.0"
end

