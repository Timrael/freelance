require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user_#{n}@example.com" }
    sequence(:password) {|n| "password#{n}" }
    password_confirmation { password }
  end
end
