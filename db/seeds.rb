# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts "Delete old users from the database and creating a default set"
for number in 1...7
  user = User.find_by_login("user#{number}")
  if user
    user.destroy
  end
  User.create!(:login=>"user#{number}", :first_name => "first#{number}", :last_name => "last#{number}", :email => "email#{number}@vt.edu")
end

puts "Removing all the buildings and creating a default set"
Building.delete_all
mccomas = Building.create!(:name=>"McComas Hall")
war = Building.create!(:name=>"War Memorial Hall")
aisb = Building.create!(:name=>"AISB")

puts "Removing all the ips and creating a default set"
Ip.delete_all
for number in 1...25
  Ip.create!(:number=>"128.173.129.#{number}", :building_id=>mccomas.id)
  Ip.create!(:number=>"128.173.108.#{number}", :building_id=>war.id)
  Ip.create!(:number=>"198.82.152.#{number}", :building_id=>aisb.id)
end

puts "Removing all OS's and adding a default set"
OperatingSystem.delete_all
win7 = OperatingSystem.create!(:name => 'Windows 7 x64 bit', :info => 'info')
osx = OperatingSystem.create!(:name => 'Mac OSX Lion', :info => 'info')

puts "Removing all locations and adding a default set"
Location.delete_all
for number in 1...7
  Location.create!(:name=>"M_Room#{number}", :building_id=>mccomas.id)
  Location.create!(:name=>"W_Room#{number}", :building_id=>war.id)
  Location.create!(:name=>"A_Room#{number}", :building_id=>aisb.id)
end

puts "Removing all the tickets and comments and adding default ones"
Ticket.delete_all
Comment.delete_all
for number in 1...7
  user = User.find_by_login("user#{number}")
  ticket = Ticket.create!(:title=>"Ticket#{number}", :submitter => user, :description => "Description for ticket #{number}", :status => "Open")
  for comments in 1...(rand(5) +1)
    Comment.create!(:user => user, :ticket => ticket, :body => "body of comment number #{comments}")
  end
end

puts "Removing all the areas and adding default ones"
Area.delete_all
Area.create!(:name => 'IT', :keywords => 'it, it_other')
Area.create!(:name => 'Facilities', :keywords => 'facilities, Fac')
Area.create!(:name => 'Marketing', :keywords => 'marketing, mark')

puts "Removing all the projects and adding default ones"
Project.delete_all
Project.create!(:name =>'Check In', :keywords => 'checkin, check_in')
Project.create!(:name =>'3.2 Run', :keywords => '3.2, 3.2 run')
Project.create!(:name =>'Findit', :keywords => 'findit, find_it')



