class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  belongs_to :category

  validates :image, presence: { message: 'を添付してください' }
  validates :name, presence: true
  validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }
end
