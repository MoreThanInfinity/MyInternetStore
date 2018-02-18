class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:edit, :update, :destroy, :replace]
  before_action :require_permission, except: [:new, :create]

  def index
    @orders=Order.all.page(params[:page]).order('created_at ASC')
  end

  def show
  end

  def edit
  end

  def new
    @order=Order.new
  end

  def replace
  end

  def create
    @order=Order.create(order_params)
    respond_to do |format|
        format.js
    end
  end

  def add_item
    @order.relations << @relation
  end

  def delete_item
    @order.relations.delete(@relation)
  end

  def destroy
    @order.destroy
  end

  private
    def order_params
      params.require(:order).permit(:name, :user_id)
    end

    def set_order
      @order=Order.find(params[:id])
    end

    def require_permission
      if current_user != Order.find(params[:id]).user
        redirect_to items_path, notice: "You cant do this!"
      end
    end
end
