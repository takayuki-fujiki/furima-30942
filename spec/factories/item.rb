FactoryBot.define do
  factory :item do
    name              { 'test' }
    description       { 'test' }
    category_id       { 1 }
    prefecture_id     { 1 }
    status_id         { 1 }
    daystoshipping_id { 1 }
    deliveryfee_id    { 1 }
    association :user
    price { 5000 }

    after(:build) do |item|
      item.image.attach(io: File.open('/Users/takayukifujiki/Downloads/xl883r.jpeg'), filename: 'test_image.jpeg', content_type: 'image/jpeg')
    end
  end
end
