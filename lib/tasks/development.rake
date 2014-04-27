namespace :app do
  namespace :dev do
    desc "Seed the dev enviroment"
    task :prime => :environment do

      Rake::Task['db:migrate']

      require 'database_cleaner'

      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean

      require 'factory_girl_rails'

      Rake::Task['db:seed'].execute

      7.times do
        FactoryGirl.create(:user)
      end

      user = FactoryGirl.build(
        :user,
        first_name: 'Admin',
        last_name: 'User',
        email: 'admin@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.can_login = true
      user.save

      puts "Admin User Credentials: #{user.email} #{user.password}"

      3.times do
        building = FactoryGirl.create(:building)
        20.times do
          FactoryGirl.create(:ip, :building => building)
          FactoryGirl.create(:location, :building => building)
        end
      end


      ["Windows 7", "Mac OSX Lion", "Ubuntu Server"].each do |name|
        os = FactoryGirl.create(:operating_system, :name => name)
        5.times do
          FactoryGirl.create(:software, :operating_system => os)
        end
      end

      for number in 1...7
        ticket = FactoryGirl.create(:ticket)
        for comments in 1...(rand(5) +1)
          FactoryGirl.create(:comment, :ticket => ticket)
        end
      end

      #areas
      FactoryGirl.create(:area, :name => 'IT', :keywords => 'it, it_other')
      FactoryGirl.create(:area, :name => 'Facilities', :keywords => 'facilities, Fac')
      FactoryGirl.create(:area, :name => 'Marketing', :keywords => 'marketing, mark')

      FactoryGirl.create(:project, :name =>'Check In', :keywords => 'checkin, check_in')
      FactoryGirl.create(:project, :name =>'3.2 Run', :keywords => '3.2, 3.2 run')
      FactoryGirl.create(:project, :name =>'Findit', :keywords => 'findit, find_it')


      require 'pry'
      names = %w(gambit magneto riddler storm batman robin nightwing)
      names.each do |name|
        item = FactoryGirl.build(:complete_item, :name => name, :location => Location.first)
        begin
          item.save
        rescue Exception => e
          binding.pry
        end
      end
    end
  end
end
