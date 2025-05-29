require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品できるとき' do
      it '全ての項目が正しく入力されていれば保存できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it '画像が空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('画像 を添付してください')
      end

      it '商品名が空では保存できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名 を入力してください')
      end

      it '商品の説明が空では保存できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明 を入力してください')
      end

      it 'カテゴリーが「---」では保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリー を選択してください')
      end

      it '商品の状態が「---」では保存できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態 を選択してください')
      end

      it '配送料の負担が「---」では保存できない' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担 を選択してください')
      end

      it '発送元の地域が「---」では保存できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域 を選択してください')
      end

      it '発送までの日数が「---」では保存できない' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数 を選択してください')
      end

      it '価格が空では保存できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('価格 は¥300〜9,999,999の間の半角数字で入力してください')
      end

      it '価格が300未満では保存できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('価格 は¥300〜9,999,999の間の半角数字で入力してください')
      end

      it '価格が10,000,000以上では保存できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('価格 は¥300〜9,999,999の間の半角数字で入力してください')
      end

      it '価格が半角数字以外では保存できない（例：全角数字）' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格 は¥300〜9,999,999の間の半角数字で入力してください')
      end

      it '価格が文字列では保存できない' do
        @item.price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格 は¥300〜9,999,999の間の半角数字で入力してください')
      end
    end
  end
end
