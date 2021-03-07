class Order
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :purchaseditem_id, :user_id,
                :item_id, :price

  with_options presence: true do
    validates :postal_code, :prefecture_id, :phone_number, :address, :city, :token
  end

  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  validates :prefecture_id, numericality: { other_than: 0 }
  validates :phone_number, format: { with: /\A[0-9]+\z/ }

  def save
    Purchaseditem.create(user_id: user_id, item_id: item_id)
    Address.create(purchaseditem_id: item_id, postal_code: postal_code, prefecture_id: prefecture_id, city: city,
                   address: address, building: building, phone_number: phone_number)
  end
end
