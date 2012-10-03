desc "Copy over necessary configuration files"
task :setup do
  `bundle install --binstubs`
  cp 'config/config.example.yml', 'config/config.yml'
  cp 'config/initializers/secret_token.example.rb', 'config/initializers/secret_token.rb'

  Rake::Task['db:create:all'].invoke
  Rake::Task['db:migrate'].invoke
  Rake::Task['db:test:prepare'].invoke
  Rake::Task['app:dev:prime'].invoke
end
