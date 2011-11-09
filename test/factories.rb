FactoryGirl.define do
   factory :user do
     first_name 'Peter'
     last_name  'Parker'
     sequence(:login){|n| "login#{n}" }
     sequence(:email){|n| "login#{n}@vt.edu"}
   end
   
   factory :area do
     name 'Area'
   end
   
   factory :project do
     name 'project'
   end

   factory :ticket do
     title 'Demo Title'
     description 'Here is a text blob about what is happeneing'
     status 'Open'
     association :submitter, :factory => :user
   end
   
   factory :comment do
     body 'some latin sayings here'
     association :user
     association :ticket
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
   end


   factory :software do
    sequence(:name) {|n| "software package #{n}"}
   end
   
   factory :building do
     sequence(:name) {|n| "building #{n}"}
   end

   factory :location do
     sequence(:name) {|n| "building #{n}"}
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

