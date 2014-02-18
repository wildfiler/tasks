FactoryGirl.define do
  factory :user, aliases: [:owner] do
    name 'John Doe'
    sequence(:email) { |n| "john#{n}@example.com"}
    password '12345678'
    role 'user'

    factory :admin do
      role 'admin'
    end
  end

end