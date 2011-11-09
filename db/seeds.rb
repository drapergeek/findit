# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
puts "Delete old users from the database and creating a default set"
for number in 1...6
  user = User.find_by_login("user#{number}")
  user.delete unless user.nil?
  User.create!(:login=>"user#{number}", :first_name => "first#{number}", :last_name => "last#{number}")
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

