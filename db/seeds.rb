# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
user = User.new(first_name: 'Admin',
                last_name: 'User',
                email: 'admin@example.com',
                password: 'password',
                password_confirmation: 'password')

user.can_login = true
user.save

puts "The first user was set up with an e-mail of #{user.email} and a password of #{user.password}, you can now login."
puts "BE SURE TO CHANGE THE USERS EMAIL AND PASSWORD"
