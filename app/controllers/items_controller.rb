class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update]
  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def show
  end

  def edit
    redirect_to root_path if current_user != @item.user || @item.order.present?
  end

  def update
    redirect_to root_path if current_user != @item.user || # @item.order.present?

                             if params[:item][:image].blank?
                               if @item.update(item_params.except(:image))
                                 redirect_to item_path(@item)
                               else
                                 render :edit
                               end
                             elsif @item.update(item_params)
                               redirect_to item_path(@item)
                             else
                               render :edit
                             end
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :shipping_fee_id, :prefecture_id, :shipping_date_id,
                                 :price, :image, :condition_id)
  end
end
