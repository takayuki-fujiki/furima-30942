FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name_JP          { '試験' }
    first_name_JP         { '試験' }
    last_name_kana        { 'テスト' }
    first_name_kana       { 'テスト' }
    birthday              { '2000-1-1' }
  end
end
