class OrdersController < ApplicationController
  require 'payjp'
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_root_if_invalid_order, only: [:index, :create]

  def index
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']  # ← 環境変数から秘密鍵をセット
      Payjp::Charge.create(
        amount: @item.price,                   # 金額（商品価格）
        card: order_params[:token], # カードトークン
        currency: 'jpy'                        # 通貨単位
      )
      @order_form.save                         # 注文と配送先の保存
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_root_if_invalid_order
    return unless current_user == @item.user || @item.order.present?

    redirect_to root_path
  end

  def order_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token)
          .merge(user_id: current_user.id, item_id: @item.id)
  end
end
