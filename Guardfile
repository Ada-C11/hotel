guard :minitest, bundler: false, autorun: false, rubygems: false do
  # with Minitest::Spec
  watch(%r{^specs?/(.*)_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^specs?/spec_helper\.rb$}) { 'specs' }
end
