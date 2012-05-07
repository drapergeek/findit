namespace :app do
  desc "Copy over necessary configuration files"
  task :setup do
    cp 'config/config.example.yml', 'config/config.yml'
    cp 'config/database.example.yml/', 'config/database.yml'
    cp 'config/initializers/secret_token.example.rb', 'config/initializers/secret_token.rb'
    puts "Files copied.  Please check the following files and change the configuration for them as neecessary"
    puts "config/config.yml"
    puts "config/database.yml"
    puts "config/initializers/secret_token.rb"
  end
end
