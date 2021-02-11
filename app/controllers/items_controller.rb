class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :user_check, only: [:edit, :update]

  def index
    @item = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    #if @item.purchaseditem.nil?
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  

  private
  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :deliveryfee_id, :prefecture_id, :daystoshipping_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def user_check
    if @item.user_id != current_user.id
      redirect_to root_path
    end
  end
end
