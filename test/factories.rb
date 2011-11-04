FactoryGirl.define do
   factory :user do
     first_name 'Peter'
     last_name  'Parker'
     sequence(:login){|n| "login#{n}" }
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

   factory :full_ticket, :parent=>:ticket do 
     association :worker, :factory=>:user
     association :project
     association :area
     priority 5
   end
   
end

