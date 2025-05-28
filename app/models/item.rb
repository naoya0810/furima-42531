class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :image, presence: { message: 'を添付してください' }
  validates :name, presence: true
end
