class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  has_one :order
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_date

  validates :image, presence: { message: 'を添付してください' }
  validates :name, presence: true
  validates :user, presence: true
  validates :description, presence: true
  validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :condition_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_fee_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_date_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :price, presence: true,
                    numericality: {
                      only_integer: true,
                      greater_than_or_equal_to: 300,
                      less_than_or_equal_to: 9_999_999,
                      message: 'は¥300〜9,999,999の間の半角数字で入力してください'
                    }
end
