FactoryGirl.define do
  factory :ticket do
    sequence(:title) { |n| "Ticket #{n} " }
    description 'My description'
    status 'Open'
    association :submitter, factory: :user

    trait :unresolved do
      status 'Open'
    end

    trait :resolved do
      status 'Resolved'
    end
  end

  factory :email, class: OpenStruct do
    to [{
      raw: 'help@example.com',
      email: 'help@example.com',
      token: 'help',
      host: 'example.com',
    }]
    from {{
      raw: 'from_user@example.com',
      email: 'from_user@example.com',
      token: 'from_user',
      name: 'From User',
      host: 'example.com',
    }}
    subject 'email subject'
    body 'Hello!'
  end

  factory :user do
    first_name { Forgery(:name).first_name }
    last_name  { Forgery(:name).last_name }
    sequence(:login){|n| "login#{n}" }
    sequence(:email){|n| "login#{n}@vt.edu"}
    password "testtest"
    password_confirmation "testtest"
    can_login true
  end

  factory :area do
    name 'Marketing'
    keywords 'marketing,Marketing,mktg'
  end

  factory :project do
    name 'Showoff'
    keywords 'marketing tv,marketingtv,rectv,showoff'
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

  factory :complete_item, parent: :item do
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
    operating_system
  end

  factory :item_type do
    sequence(:name) { |n| "item type #{n}" }
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
