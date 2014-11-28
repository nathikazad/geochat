# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "apipie-rails"
  s.version = "0.2.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pavel Pokorny", "Ivan Necas"]
  s.date = "2014-08-29"
  s.description = "Rails REST API documentation tool"
  s.email = ["pajkycz@gmail.com", "inecas@redhat.com"]
  s.homepage = "http://github.com/Pajk/apipie-rails"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Rails REST API documentation tool"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rails>, [">= 3.0.10"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 2.14.2"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<maruku>, [">= 0"])
      s.add_development_dependency(%q<RedCloth>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 3.0.10"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, ["~> 2.14.2"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<maruku>, [">= 0"])
      s.add_dependency(%q<RedCloth>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.0.10"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, ["~> 2.14.2"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<maruku>, [">= 0"])
    s.add_dependency(%q<RedCloth>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
  end
end
