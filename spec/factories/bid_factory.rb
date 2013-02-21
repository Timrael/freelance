require 'factory_girl'

FactoryGirl.define do
  factory :bid do
    price 1000
    sequence(:description) {|n| "I'm super software engineer ##{n}, give the project to me!" }
    user
    project
  end
end
