FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { Faker::Internet.free_email }
    password              { 'T1' + Faker::Internet.password(min_length: 4) }
    password_confirmation { password }
    last_name_JP          { '試験' }
    first_name_JP         { '試験' }
    last_name_kana        { 'テスト' }
    first_name_kana       { 'テスト' }
    birthday              { '2000-1-1' }
  end
end
