FactoryBot.define do
  factory :order do
    postal_code   { '123-4567' }
    prefecture_id { 3 }
    city          { 'なんたら市' }
    address       { 'カンタラ123' }
    building      { 'ぬるぽマンション' }
    phone_number  { '09012345678' }
    item_id       { 2 }
    user_id       { 3 }
    token         { 'tok_awsedrftgyhuji123' }
  end
end
