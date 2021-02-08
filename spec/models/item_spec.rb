require 'rails_helper'

describe Item do
  before do
    @user = FactoryBot.build(:user)
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('/Users/takayukifujiki/Downloads/xl883r.jpeg')
  end

  describe '商品出品機能' do
    context '出品できるとき' do
      it "image、name、description、status、category、deliveryfee、daystoshipping、priceが入力されていると出品できる" do
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
    it "imageが空では登録できない" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it "nameが空では登録できない" do
      @item.name = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it "statusが空では登録できない" do
      @item.status_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Status can't be blank")
    end

    it "categryが空では登録できない" do
      @item.category_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end

    it "daystoshippingが空では登録できない" do
      @item.daystoshipping_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Daystoshipping can't be blank")
    end

    it "deliveryfeeが空では登録できない" do
      @item.deliveryfee_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Deliveryfee can't be blank")
    end

    it "priceが空では登録できない" do
      @item.price = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is invalid")
    end

    it "priceが300より小さくては登録できない" do
      @item.price = "200"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not included in the list")
    end

    it "priceが9999999より大きくては登録できない" do
      @item.price = "10000000"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not included in the list")
    end

    it "priceが全角文字では登録できない" do
      @item.price = "２００００あいうえお"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end
  end
  end
end