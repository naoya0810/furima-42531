class OrderForm
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id,
                :city, :addresses, :building, :phone_number, :token

  with_options presence: { message: 'を入力してください' } do
    validates :user_id
    validates :item_id
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :addresses
    validates :phone_number
    validates :token
  end

  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'は「123-4567」の形式で入力してください' }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10〜11桁の数字で入力してください' }
  validates :prefecture_id, numericality: { other_than: 0, message: 'を選択してください' }

  def save
    true
  end
