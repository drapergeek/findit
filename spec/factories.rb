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
end
