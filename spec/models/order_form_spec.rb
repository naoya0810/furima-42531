require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @user = FactoryBot.build(:user)
    @item = FactoryBot.build(:item)
    @user.save
    @item.save
    @order_form = OrderForm.new(
      user_id: @user.id,
      item_id: @item.id,
      postal_code: '123-4567',
      prefecture_id: 2,
      city: '横浜市',
      addresses: '青山1-1-1',
      building: '柳ビル103',
      phone_number: '09012345678',
      token: 'tok_abcdefghijk00000000000000000'
    )
  end

  describe '商品購入機能' do
    context '購入できるとき' do
      it '全ての値が正しく入力されていれば購入できる' do
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
        expect(@order_form.errors.full_messages).to include('Tokenを入力してください')
      end

      it 'postal_codeが空では購入できない' do
        @order_form.postal_code = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postal codeを入力してください')
      end

      it 'postal_codeがハイフンなしでは購入できない' do
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
        expect(@order_form.errors.full_messages).to include('Cityを入力してください')
      end

      it 'addressesが空では購入できない' do
        @order_form.addresses = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Addressesを入力してください')
      end

      it 'phone_numberが空では購入できない' do
        @order_form.phone_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone numberを入力してください')
      end

      it 'phone_numberが12桁以上では購入できない' do
        @order_form.phone_number = '090123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number は10〜11桁の数字で入力してください')
      end

      it 'phone_numberにハイフンがあると購入できない' do
        @order_form.phone_number = '090-1234-5678'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number は10〜11桁の数字で入力してください')
      end

      it 'user_idが空だと購入できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Userを入力してください')
      end

      it 'item_idが空だと購入できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Itemを入力してください')
      end
    end
  end
end
