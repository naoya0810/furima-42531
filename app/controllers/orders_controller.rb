class OrdersController < ApplicationController
  require 'payjp'
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_root_if_invalid_order, only: [:index, :create]

  def index
    @order_form = OrderForm.new
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def create
    @order_form = OrderForm.new(order_params)
    @item = Item.find(params[:item_id]) # ← 必須！
    if @order_form.valid?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
      @order_form.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY'] # ← これも必須！
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
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end
end
