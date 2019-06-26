Gem::Specification.new do |s|
  s.name        = 'puppet-lint-recurse_file-check'
  s.version     = '0.1.0'
  s.homepage    = 'https://github.com/jarretlavallee/puppet-recurse_file-check'
  s.license     = 'MIT'
  s.author      = 'Jarret Lavallee'
  s.email       = 'jarret.lavallee@gmail.com'
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.summary     = 'puppet-lint recurse_file check'
  s.description = <<-EOF
    Extends puppet-lint to ensure file resources do not recurse enabled.
  EOF

  s.add_dependency             'puppet-lint', '>= 1.1', '< 3.0'
end
