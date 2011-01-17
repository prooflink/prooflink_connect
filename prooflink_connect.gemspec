# -*- encoding: utf-8 -*-
require File.expand_path("../lib/prooflink_connect/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "prooflink_connect"
  s.version     = ProoflinkConnect::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chiel Wester"]
  s.email       = "chiel.wester@holder.nl"
  s.homepage    = "https://github.com/chielwester/prooflink_connect"
  s.summary     = "Make a connection to the prooflink connect api"
  s.description = "Make a connection to the prooflink connect api for single sign on authentication"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "prooflink_connect"

  s.add_development_dependency "bundler", ">= 1.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
