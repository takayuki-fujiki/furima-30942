require 'rails_helper'
RSpec.describe Order, type: :model do
  describe '注文情報の保存' do
    before do
      @item = FactoryBot.create(:item)
      @item.image = fixture_file_upload('/Users/takayukifujiki/Downloads/xl883r.jpeg')
      @user = FactoryBot.create(:user)
      @order = FactoryBot.build(:order, user_id: @user.id, item_id: @item.id)
    end

    context '保存できるとき' do
      it 'すべての情報が正しく入力されていれば保存できること' do
        expect(@order).to be_valid
      end

      it 'buildingは空欄でも保存できること' do
        @order.building = ''
        expect(@order).to be_valid
      end
    end

    context '保存できないとき' do
      context 'postal_code起因' do
        it 'postal_codeが空欄では保存できないこと' do
          @order.postal_code = ''
          @order.valid?
          expect(@order.errors.full_messages).to include("Postal code can't be blank",
                                                         'Postal code is invalid. Include hyphen(-)')
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
      end
      context 'prefecture起因' do
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
      end
      context 'city起因' do
        it 'cityが空欄では保存できないこと' do
          @order.city = ''
          @order.valid?
          expect(@order.errors.full_messages).to include("City can't be blank")
        end
      end
      context 'address起因' do
        it 'addressが空欄では保存できないこと' do
          @order.address = ''
          @order.valid?
          expect(@order.errors.full_messages).to include("Address can't be blank")
        end
      end
      context 'phone_number起因' do
        it 'phone_numberが空欄では保存できないこと' do
          @order.phone_number = ''
          @order.valid?
          expect(@order.errors.full_messages).to include("Phone number can't be blank")
        end
        it 'phone_numberは半角数字のみでないと保存できないこと' do
          @order.phone_number = '０９０１２３４５６７８'
          @order.valid?
          expect(@order.errors.full_messages).to include('Phone number is invalid')
        end
        it 'phone_numberは半角数字でも12桁以上では保存できないこと' do
          @order.phone_number = '123456789012'
          @order.valid?
          expect(@order.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
        end
        it 'phone_numberにハイフンが入ると保存できないこと' do
          @order.phone_number = '090-1234-12'
          @order.valid?
          expect(@order.errors.full_messages).to include('Phone number is invalid')
        end
      end
      context 'token,user,item起因' do
        it 'tokenが空では登録できないこと' do
          @order.token = ''
          @order.valid?
          expect(@order.errors.full_messages).to include("Token can't be blank")
        end

        it 'item_idが空の場合登録できない' do
          @order.item_id = ''
          @order.valid?
          expect(@order.errors.full_messages).to include("Item can't be blank")
        end

        it 'user_idが空の場合登録できない' do
          @order.user_id = ''
          @order.valid?
          expect(@order.errors.full_messages).to include("User can't be blank")
        end
      end
    end
  end
end
