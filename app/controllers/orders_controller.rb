class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :user_check, only: [:index]

  def index
    @order = Order.new
    purchaseditem = Purchaseditem.new
    address = Address.new
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      order_pay
      @order.save
      binding.pry
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number, :price).merge(
      item_id: @item.id, token: params[:token], user_id: current_user.id
    )
  end

  def order_pay
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def user_check
    if user_signed_in?
      if @item.user_id == current_user.id
        redirect_to root_path
      elsif !@item.purchaseditem.nil?
        redirect_to root_path
      redirect_to new_user_session_path
      end
    end
  end
end
