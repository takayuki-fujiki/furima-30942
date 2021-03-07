class Order
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, :prefecture_id, :phone_number, :address, :city, :token, :user_id, :item_id
  end

  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  validates :prefecture_id, numericality: { other_than: 0 }
  validates :phone_number, format: { with: /\A[0-9]+\z/ }, length: { maximum: 11 }

  def save
    Purchaseditem.create(user_id: user_id, item_id: item_id)
    purchaseditem = Purchaseditem.find_by(item_id: item_id)
    Address.create(purchaseditem_id: purchaseditem.item_id, postal_code: postal_code, prefecture_id: prefecture_id, city: city,
                   address: address, building: building, phone_number: phone_number)
  end
end
