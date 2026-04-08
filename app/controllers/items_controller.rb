class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit

  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def correct_user
    @item = Item.find(params[:id])
    redirect_to root_path if @item.user != current_user
  end

  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :price,
      :image,
      :category_id,
      :shipping_fee_id,
      :prefecture_id,
      :shipping_day_id,
      :condition_id
    ).merge(user_id: current_user.id)
  end
end
