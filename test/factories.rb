FactoryGirl.define do

   factory :user do
     first_name { Forgery(:name).first_name }
     last_name  { Forgery(:name).last_name }
     sequence(:login){|n| "login#{n}" }
     sequence(:email){|n| "login#{n}@vt.edu"}
     password "testtest"
     password_confirmation "testtest"
   end

   factory :area do
     name 'Marketing'
     keywords 'marketing,Marketing,mktg'
   end
   
   factory :project do
     name 'Showoff'
     keywords 'marketing tv,marketingtv,rectv,showoff'
   end

   factory :ticket do
     title 'Demo Title'
     description 'Here is a text blob about what is happeneing'
     status 'Open'
     association :submitter, :factory => :user
   end
   
   factory :comment do |u|
     u.body 'some latin sayings here'
     u.association :user
     u.association :ticket
   end

   factory :full_ticket, :parent=>:ticket do 
     association :worker, :factory=>:user
     association :project
     association :area
     priority 5
   end

   factory :item do
    sequence(:name) {|n| "computer#{n}"}
    type_of_item "Desktop"
    in_use true
   end

   factory :complete_item, :parent => :item do
     priority 4
     location
     user
     make "Apple"
     model "Macbook Pro 13''"
     ram "4096"
     hard_drive "150"
     sequence(:vt_tag) { |n| "VT000#{n}" }
     sequence(:serial) { |n| "TBS#{n}" }
     purchased_at 2.years.ago
     warranty_expires_at 2.months.from_now
     os "Mac OS X Lion"
   end


   factory :software do
    sequence(:name) {|n| "software package #{n}"}
   end

   factory :building do
     sequence(:name) {|n| "building #{n}"}
   end

   factory :location do
     sequence(:name) {|n| "room #{n}"}
     association :building
   end

   factory :ip do
    sequence(:number) {|n| "128.173.129.#{n}"}
    association :building
   end

   factory :operating_system do
     sequence(:name) {|n| "operating syste #{n}"}
   end

end

