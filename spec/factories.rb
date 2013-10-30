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
end
