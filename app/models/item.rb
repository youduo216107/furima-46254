class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_day

  validates :image,                   
            :name,                    
            :description,             presence: { message: 'を入力してください' }
  validates :price,                   presence: { message: 'を入力してください' },
                                       numericality: {
                                        only_integer: true,
                                        greater_than_or_equal_to: 300,
                                        less_than_or_equal_to: 9_999_999,
                                        message: 'は300円以上、9,999,999円以下の半角数字で入力してください'
                                      }
  validates :category_id,             
            :condition_id,            
            :prefecture_id,           
            :shipping_fee_id,         
            :shipping_day_id,         numericality: { other_than: 0, message: 'を選択してください' }
end
