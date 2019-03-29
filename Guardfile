guard :minitest, test_folders: ['spec', 'specs'], bundler: false, autorun: false, rubygems: false, all_after_pass: true  do
  spec_dir = "spec"
  spec_dir = "specs" if File.directory?("specs")

  # with Minitest::Spec
  watch(%r{^specs?/(.*)_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})         { |m| "#{spec_dir}/#{m[1]}_spec.rb" }
  watch(%r{^specs?/spec_helper\.rb$}) { spec_dir }
end
