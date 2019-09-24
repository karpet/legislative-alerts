FactoryBot.define do
  sequence(:email) { |n| Faker::Internet.safe_email name: 'User %d' % n }
end

FactoryBot.define do
  factory :user do
    email
    password { '12345678' }
    password_confirmation { '12345678' }
    if User.devise_modules.include?(:confirmable)
      confirmed_at { Time.now }
    end
  end
end
