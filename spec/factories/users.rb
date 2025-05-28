FactoryBot.define do
  factory :user do
    nickname { 'テストユーザー' }
    email { 'test@example.com' }
    password { 'password123' }
    password_confirmation { 'password123' }
  end
end
