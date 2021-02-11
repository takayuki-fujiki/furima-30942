class Item < ApplicationRecord
  with_options presence: true do
    validates :image, :name, :description, :category_id, :status_id, :deliveryfee_id, :prefecture_id, :daystoshipping_id, :price
  end

  validates :price, format: { with: /\A[0-9]+\z/ }, inclusion: { in: 300..9_999_999 }, numericality: true

belongs_to :user
has_one :purchaseditem
has_one_attached :image

extend ActiveHash::Associations::ActiveRecordExtensions
belongs_to :category
belongs_to :status
belongs_to :deliveryfee
belongs_to :prefecture
belongs_to :daystoshipping, optional: true
belongs_to :deliveryfee, optional: true

end
