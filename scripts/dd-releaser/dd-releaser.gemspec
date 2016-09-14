require_relative 'lib/dd-releaser/version'

Gem::Specification.new do |s|
  s.name        = 'dd-releaser'
  s.version     = DDReleaser::VERSION
  s.homepage    = 'http://github.com/ddfreyne/dd-releaser'
  s.summary     = 'Release script'

  s.author  = 'Denis Defreyne'
  s.email   = 'denis.defreyne@stoneship.org'
  s.license = 'MIT'

  s.files =
    Dir['[A-Z]*'] +
    Dir['{bin,lib,spec}/**/*'] +
    ['dd-releaser.gemspec']
  s.executables        = ['dd-release']
  s.require_paths      = ['lib']

  s.rdoc_options     = ['--main', 'README.md']
  s.extra_rdoc_files = ['LICENSE', 'README.md', 'NEWS.md']

  s.required_ruby_version = '>= 2.1.0'

  s.add_development_dependency('bundler', '>= 1.7.10', '< 2.0')
end
