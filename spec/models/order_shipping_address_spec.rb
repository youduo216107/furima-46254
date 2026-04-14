require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_shipping_address = FactoryBot.build(
      :order_shipping_address,
      user_id: user.id,
      item_id: item.id
      )
  end

  describe '購入情報の保存' do
    context '購入できる場合' do
      it '全く正しく入力されていれば購入できる' do
        expect(@order_shipping_address).to be_valid
      end

      it '建物名が空でも購入できる' do
        @order_shipping_address.building = ''
        expect(@order_shipping_address).to be_valid
      end
    end

    context '購入できない場合' do
      it 'tokeが空では購入できない' do
        @order_shipping_address.token = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('決済情報 を入力してください')
      end

      it 'postal_codeが空では購入できない' do
        @order_shipping_address.postal_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('郵便番号 は「123-4567」の形式で入力してください')
      end

      it 'postal_codeが半角ハイフンを含まない場合は購入できない' do
        @order_shipping_address.postal_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('郵便番号 は「123-4567」の形式で入力してください')
      end

      it 'prefecture_idが0では購入できない' do
        @order_shipping_address.prefecture_id = 0
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('都道府県 を選択してください')
      end

      it 'cityが空では購入できない' do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('市区町村 を入力してください')
      end

      it 'addressが空では購入できない' do
        @order_shipping_address.address = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('番地 を入力してください')
      end

      it 'phone_numberが空では購入できない' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('電話番号 は半角数字のみ11桁で入力してください')
      end

      it 'phone_numberが12桁以上では購入できない' do
        @order_shipping_address.phone_number = '090123456789'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('電話番号 は半角数字のみ11桁で入力してください')
      end
    end
  end
end
