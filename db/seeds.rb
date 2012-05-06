# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


def ask(question)
  puts question
  STDNIN.gets.chomp
end
first_name = 'John'
last_name = 'Doe'
email = 'admin@test.com'
password = 'testtest'
if Rails.env.production?
 puts 'The next few prompts are for setting up the initial user.'
 first_name = ask('First name for first user')
 last_name = ask('Last name for first user')
 email = ask('Email for first user')
 password = ask('Password for first user')
end
user = User.new(first_name: first_name,
                last_name: last_name,
                email: email,
                password: password,
                password_confirmation: password)
user.can_login = true
user.save
puts "The first user was set up with an e-mail of #{user.email} and a password of #{password}, you can now login"
