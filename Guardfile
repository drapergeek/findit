# A sample Guardfile
# More info at https://github.com/guard/guard#readme
guard 'livereload' do
  watch(%r{app/.+\.(erb|haml)})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{(public/|app/assets).+\.(css|js|html)})
  watch(%r{(app/assets/.+\.css)\.s[ac]ss}) { |m| m[1] }
  watch(%r{(app/assets/.+\.js)\.coffee}) { |m| m[1] }
  watch(%r{config/locales/.+\.yml})
end


guard 'test' do
  watch(%r{^lib/(.+)\.rb$})     { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^test/.+_test\.rb$})
  watch('test/test_helper.rb')  { "test" }

  # Rails example
  watch(%r{^lib//(.+)\.rb$})      		             { |m| "test/unit" }
  watch(%r{^app/models/(.+)\.rb$})                   { |m| "test/unit/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/(.+)\.rb$})              { |m| "test/functional/#{m[1]}_test.rb" }
  watch(%r{^app/views/.+\.rb$})                      { "test/integration" }
  watch('app/controllers/application_controller.rb') { ["test/functional", "test/integration"] }
end


