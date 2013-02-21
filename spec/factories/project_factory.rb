require 'factory_girl'

FactoryGirl.define do
  factory :project do
    sequence(:title) {|n| "Create a new PHP site number #{n}" }
    sequence(:description) {|n| "For the site number #{n} u should use ur hands and brain!" }
    association :author, factory: :user
  end
end
