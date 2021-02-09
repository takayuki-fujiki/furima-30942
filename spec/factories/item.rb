FactoryBot.define do
  factory :item do
    name              {"test"}
    description       {"test"}
    category_id       {1}
    prefecture_id     {1}
    status_id         {1}
    daystoshipping_id {1}
    deliveryfee_id    {1}
    association        :user
    price             {5000}
  end
end