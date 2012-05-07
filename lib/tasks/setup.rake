namespace :app do
  desc "Copy over necessary configuration files"
  task :setup do
    cp 'config/config.example.yml', 'config/config.yml'
    unless ENV['travis'] == 'true'
      cp 'config/database.example.yml', 'config/database.yml'
    end
    cp 'config/initializers/secret_token.example.rb', 'config/initializers/secret_token.rb'
    puts "Files copied.  Please change all the information in the files as necessary"
    puts "Once the files are set up properly, you can run rake app:dev:prime to set up a local development instance"
  end
end
