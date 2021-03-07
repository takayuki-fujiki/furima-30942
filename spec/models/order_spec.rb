require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '注文情報の保存' do
    before do
      @order = FactoryBot.build(:order)
    end

    it 'すべての情報が正しく入力されていれば保存できること' do
      expect(@order).to be_valid
    end

    it 'postal_codeが空欄では保存できないこと' do
      @order.postal_code = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("Postal code can't be blank", 'Postal code is invalid. Include hyphen(-)')
    end
    it 'prefecture_idが空欄では保存できないこと' do
      @order.prefecture_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Prefecture can't be blank")
    end
    it 'prefecture_idが半角数字以外では保存できないこと' do
      @order.prefecture_id = 'あああ'
      @order.valid?
      expect(@order.errors.full_messages).to include('Prefecture is not a number')
    end
    it 'cityが空欄では保存できないこと' do
      @order.city = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("City can't be blank")
    end
    it 'addressが空欄では保存できないこと' do
      @order.address = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("Address can't be blank")
    end
    it 'buildingは空欄でも保存できること' do
      @order.building = ''
      expect(@order).to be_valid
    end
    it 'phone_numberが空欄では保存できないこと' do
      @order.phone_number = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'postal_codeが全角文字では保存できないこと' do
      @order.postal_code = '１２３−４５６７'
      @order.valid?
      expect(@order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end
    it 'postal_codeは半角数字でもハイフンがないと保存できないこと' do
      @order.postal_code = '1234567'
      @order.valid?
      expect(@order.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end
    it 'phone_numberは半角数字のみでないと保存できないこと' do
      @order.phone_number = '０９０１２３４５６７８'
      @order.valid?
      expect(@order.errors.full_messages).to include('Phone number is invalid')
    end
    it 'tokenが空では登録できないこと' do
      @order.token = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("Token can't be blank")
    end
  end
end
