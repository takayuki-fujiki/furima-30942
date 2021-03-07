class OrdersController < ApplicationController
  def index
    @order = Order.new
    @item = Item.find(params[:item_id])
    purchaseditem = Purchaseditem.new
    address = Address.new

    user_check
    if @item.user_id == current_user.id || !@item.purchaseditem.nil? && @item.purchaseditem.item_id == @item.id
      redirect_to root_path
    end
  end

  def new
    @order = Order.new
  end

  def create
    @item = Item.find(params[:item_id])
    @user = current_user
    @order = Order.new(order_params)
    if @order.valid?
      order_pay
      @order.save
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
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def user_check
    if user_signed_in?
    else
      redirect_to root_path
    end
  end
end
