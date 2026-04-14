class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_root
  
  def index
    @order_shipping_address = OrderShippingAddress.new
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def create
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_shipping_address = OrderShippingAddress.new(order_shipping_address_params)
    if @order_shipping_address.valid?
      pay_item
      @order_shipping_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_root
    redirect_to root_path if @item.user == current_user || @item.order.present?
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end

  def order_shipping_address_params
    params.require(:order_shipping_address).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :address,
      :building,
      :phone_number,
    ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
end
