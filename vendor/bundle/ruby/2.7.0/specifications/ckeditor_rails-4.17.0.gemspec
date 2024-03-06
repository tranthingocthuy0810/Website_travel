# -*- encoding: utf-8 -*-
# stub: ckeditor_rails 4.17.0 ruby lib

Gem::Specification.new do |s|
  s.name = "ckeditor_rails".freeze
  s.version = "4.17.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tse-Ching Ho".freeze]
  s.date = "2022-05-21"
  s.description = "CKEditor is a javascript library of the WYSIWYG rich-text editor. This gem integrates CKEditor with Rails asset pipeline for easy of use.".freeze
  s.email = ["tsechingho@gmail.com".freeze]
  s.homepage = "https://github.com/tsechingho/ckeditor-rails".freeze
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Integrate CKEditor javascript library with Rails asset pipeline".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<railties>.freeze, [">= 3.0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 1.0"])
    s.add_development_dependency(%q<rails>.freeze, [">= 3.0"])
    s.add_development_dependency(%q<thor>.freeze, [">= 0.14"])
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.0"])
    s.add_dependency(%q<rails>.freeze, [">= 3.0"])
    s.add_dependency(%q<thor>.freeze, [">= 0.14"])
  end
end
