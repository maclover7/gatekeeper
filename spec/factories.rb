require 'faker'
require 'factory_girl_rails'

FactoryGirl.define do
  factory :oauth_access_token, class: "Doorkeeper::AccessToken" do
    transient do
      user nil
    end

    resource_owner_id { user.try(:id) }
    application_id 1
    token 'abc123'

    trait :with_application do
      association :application, factory: :oauth_application
    end
  end

  factory :oauth_application, class: "Doorkeeper::Application" do
    sequence(:name) { |n| "Application #{n}" }
    sequence(:uid) { |n| n }
    redirect_uri "https://www.example.com/callback"
  end

  factory :user do |f|
    f.email { Faker::Internet.email }
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.password "foobarfoobar"
    f.password_confirmation { |u| u.password }
    admin false
  end
end
