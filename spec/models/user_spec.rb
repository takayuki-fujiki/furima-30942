require 'rails_helper'

describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "nicknameとemail、passwordとpassword_confirmation、漢字カナ氏名、誕生日が存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "passwordが６文字以上であれば登録できる" do
        @user.password = "123ABc"
        @user.password_confirmation = "123ABc"
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
    it "nicknameが空では登録できない" do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it "emailが空では登録できない" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "emailに@が無いと登録できない" do
      @user.email = "123gmail.com"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "パスワードが空では登録できない" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "パスワードが半角英語のみでは登録できない" do
      @user.password = "asdfgh"
      @user.password_confirmation = "asdfgh"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it "パスワードが数字のみでは登録できない" do
      @user.password = "123456"
      @user.password_confirmation = "123456"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it "パスワードは全角英数混合では登録できない" do
      @user.password = "あいう１２３"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it "パスワード確認が空では登録できない" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "漢字名字が空では登録できない" do
      @user.last_name_JP = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name jp can't be blank")
    end

    it "名字は全角（漢字・ひらがな・カタカナ）でないと登録できない" do
      @user.last_name_JP = "Abc123"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name jp is invalid")
    end

    it "名前が空では登録できない" do
      @user.first_name_JP = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name jp can't be blank")
    end

    it "名前は全角（漢字・ひらがな・カタカナ）でないと登録できない" do
      @user.first_name_JP = "Abc123"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name jp is invalid")
    end

    it "カナ名字が空では登録できない" do
      @user.last_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it "名字のフリガナは全角カタカナでないと登録できない" do
      @user.last_name_kana = "1月January"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana is invalid")
    end

    it "カナ名前が空では登録できない" do
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it "名前のフリガナは全角カタカナでないと登録できない" do
      @user.first_name_kana = "1月January"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana is invalid")
    end

    it "誕生日が空では登録できない" do
      @user.birthday = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end

    it "パスワードが5文字以下では登録できない" do
      @user.password = "aaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "emailは重複登録できない" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    end
  end
end