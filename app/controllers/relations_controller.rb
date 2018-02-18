class RelationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_relation, only: [ :destroy]
  before_action :require_permission, except: [:new, :create]

  def index
    @relations=Relation.all.page(params[:page]).order('created_at DESC')
  end

  #def edit
  #end

  def new
    @relation=Relation.new(item_id: params[:item_id])
    @orders=current_user.orders
    @item=Item.find(params[:item_id])
  end

  def create
    @relation=Relation.new(relation_params)
    respond_to do |format|
      if @relation.save!
        format.js
      else
        format.html{render :new, notice: "#{@relation.errors.full_messages}"}
      end
    end
  end

  #def update
  #  respond_to do |format|
  #    if @relation.update(relation_params)
  #      format.js
  #    else
  #      format.html{render :new, notice: "#{@relation.errors.full_messages}"}
  #    end
  #  end
  #end

  def destroy
    @relation.destroy
  end

  private
    def set_relation
      @relation=Relation.find(params[:id])
    end
    def relation_params
      params.require(:relation).permit(:quantity, :message, :status, :user_id, :item_id, :order_id)
    end

    def set_item
      @relation=Relation.find(params[:id])
    end

    def require_permission
      if current_user != Relation.find(params[:id]).user
        redirect_to items_path, notice: "You cant do this!"
      end
    end

end
