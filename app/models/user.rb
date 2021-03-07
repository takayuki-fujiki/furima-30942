class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname, :email, :last_name_JP, :first_name_JP, :last_name_kana, :first_name_kana, :birthday
  end

  with_options format: /\A[ぁ-んァ-ン一-龥]/ do
    validates :last_name_JP, :first_name_JP
  end

  with_options format: /\A[ァ-ヶー－]+\z/ do
    validates :last_name_kana, :first_name_kana
  end

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}+\z/i }

  has_many :items
  has_many :purchaseditems
end
