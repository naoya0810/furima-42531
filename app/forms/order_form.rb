class OrderForm
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :addresses
    validates :phone_number
    validates :token
  end

  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'は「123-4567」の形式で入力してください' }, if: -> { postal_code.present? }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10〜11桁の数字で入力してください' }, if: -> { phone_number.present? }
  validates :prefecture_id, numericality: { other_than: 0, message: 'を選択してください' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      addresses: addresses,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end
