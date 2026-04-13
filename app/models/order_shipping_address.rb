class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address,
                :building, :phone_number, :user_id, :item_id, :token

  validates :token,                       presence: true

  validates :postal_code,                 format: { with: /\A\d{3}-\d{4}\z/,
                                                    message: 'は「123-4567」の形式で入力してください' }

  validates :prefecture_id,               numericality: { other_than: 0, message: 'を選択してください' }
  
  validates :city,              
            :address,                     presence: { message: 'を入力してください'}

  validates :phone_number,                format: { with: /\A\d{10,11}\z/,
                                                    message: 'は半角数字のみ11桁で入力してください' }
  validates :user_id,
            :item_id,                     presence: true

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,              
      address: address,           
      phone_number: phone_number,
      order_id: order.id
    )
  end

end
