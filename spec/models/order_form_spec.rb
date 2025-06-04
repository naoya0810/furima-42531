require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_form = FactoryBot.build(:order_form,
                                   user_id: @user.id,
                                   item_id: @item.id,
                                   token: 'tok_abcdefghijk00000000000000000',
                                   postal_code: '123-4567',
                                   prefecture_id: 2,
                                   city: '渋谷区',
                                   addresses: '1-1',
                                   building: 'テストビル',
                                   phone_number: '09012345678')
    sleep(0.1) # DBアクセスの速度調整（必要なら）
  end

  describe '商品購入機能' do
    context '購入できるとき' do
      it 'すべての情報が正しく入力されていれば購入できる' do
        expect(@order_form).to be_valid
      end

      it 'buildingが空でも購入できる' do
        @order_form.building = ''
        expect(@order_form).to be_valid
      end
    end

    context '購入できないとき' do
      it 'tokenが空では購入できない' do
        @order_form.token = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Token を入力してください')
      end

      it 'postal_codeが空では購入できない' do
        @order_form.postal_code = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postal code を入力してください')
      end

      it 'postal_codeにハイフンが含まれていないと購入できない' do
        @order_form.postal_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postal code は「123-4567」の形式で入力してください')
      end

      it 'prefecture_idが0では購入できない' do
        @order_form.prefecture_id = 0
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Prefecture を選択してください')
      end

      it 'cityが空では購入できない' do
        @order_form.city = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('City を入力してください')
      end

      it 'addressesが空では購入できない' do
        @order_form.addresses = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Addresses を入力してください')
      end

      it 'phone_numberが空では購入できない' do
        @order_form.phone_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number を入力してください')
      end

      it 'phone_numberが12桁以上では購入できない' do
        @order_form.phone_number = '090123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number は10〜11桁の数字で入力してください')
      end

      it 'phone_numberにハイフンが含まれていると購入できない' do
        @order_form.phone_number = '090-1234-5678'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number は10〜11桁の数字で入力してください')
      end

      it 'phone_numberが9桁以下では購入できない' do
        @order_form.phone_number = '090123456' # 9桁
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone numberは10〜11桁の数字で入力してください')
      end

      it 'user_idが空では購入できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('User を入力してください')
      end

      it 'item_idが空では購入できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Item を入力してください')
      end
    end
  end
end
