class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy, :vote]
  def index
    @items=Item.all.page(params[:page]).order('created_at DESC')
  end

  def show
  end

  def edit
  end

  def new
    @item=Item.new
  end

  def create
    @item=Item.new(item_params)
    respond_to do |format|
      if @item.save
        format.js
      else
        format.html{render :new, notice: "#{@item.errors.full_messages}"}
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.js
      else
        format.html{render :new, notice: "#{@item.errors.full_messages}"}
      end
    end
  end

  def vote
    if !current_user.voted_up_on? @item
      @item.liked_by current_user
    elsif current_user.voted_up_on? @item
      @item.disliked_by current_user
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @item.destroy
  end

  private
    def item_params
      params.require(:item).permit(:photo, :availability, :name, :cost, :information)
    end

    def set_item
      @item=Item.find(params[:id])
    end

    def require_permission
      if User.find(1) != Item.find(params[:id]).user
        redirect_to items_path, notice: "You cant do this!"
      end
    end
end
