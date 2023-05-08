Gem::Specification.new do |s|
  s.name = "cbor-dcbor"
  s.version = "0.0.2"
  s.summary = "CBOR (Concise Binary Object Representation) \"dCBOR\" encoding"
  s.description = %q{cbor-dcbor implements "dCBOR" encoding for CBOR, RFC 8949}
  s.author = "Carsten Bormann"
  s.email = "cabo@tzi.org"
  s.license = "Apache-2.0"
  s.homepage = "http://cbor.io/"
  s.test_files = Dir['test/**/*.rb']
  s.files = Dir['lib/**/*.rb'] + %w(cbor-dcbor.gemspec) + Dir['bin/**/*.rb']
  s.executables = Dir['bin/**/*.rb'].map {|x| File.basename(x)}
  s.required_ruby_version = '>= 1.9.2'

  s.require_paths = ["lib"]
end
