require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品登録' do
    # 正常に登録できているケース
    context '登録できる場合' do
      it '全てが正しく入力できていれば登録' do
        expect(@item).to be_valid
      end
    end

    # 登録できないケース
    context '登録できない場合' do
      it 'imageが空では登録できない' do
        @item.image.purge
        @item.valid?
        expect(@item.errors.full_messages).to include("商品画像 を入力してください")
      end
    

      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名 を入力してください")
      end

      it 'descriptionが空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明 を入力してください")
      end

      it 'categoryが0では登録できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリー を選択してください")
      end

      it 'conditionが0では登録できない' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態 を選択してください")
      end

      it 'shipping_feeが0では登録できない' do
        @item.shipping_fee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担 を選択してください")
      end

      it 'prefectureが0では登録できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域 を選択してください")
      end

      it 'shipping_dayが0では登録できない' do
        @item.shipping_day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数 を選択してください")
      end

      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格 は300円以上、9,999,999円以下で入力してください")
      end

      it 'priceが300円未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("価格 は300円以上、9,999,999円以下で入力してください")
      end

      it 'priceが9,999,999円以上では登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("価格 は300円以上、9,999,999円以下で入力してください")
      end

      it 'priceに数字以外では登録できない' do
        @item.price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格 は300円以上、9,999,999円以下で入力してください")
      end

      it 'userが紐づいていなければ登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("出品者 が紐づいていません")
      end

    end
  end
end
