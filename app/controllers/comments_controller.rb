class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :vote]
  before_action :require_permission, only: [:edit, :update, :destroy ]

  def index
    @comments=Comment.all.page(params[:page]).order('created_at DESC')
  end

  def show
  end

  def edit
  end

  def new
    @comment=Comment.new(item_id: params[:item_id])
    @item=Item.find(params[:item_id])
  end

  def create
    @comment=Comment.new(comment_params)

    respond_to do |format|
      if @comment.save!
        @item=@comment.item
        format.js
      else
        format.html{render :new, notice: "#{@comment.errors.full_messages}"}
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.js
      else
        format.html{render :new, notice: "#{@comment.errors.full_messages}"}
        format.js
      end
    end
  end

  def vote
    if !current_user.voted_up_on? @comment
      @comment.liked_by current_user
    elsif current_user.voted_up_on? @comment
      @comment.disliked_by current_user
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment.destroy!
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :attachment, :user_id, :item_id)
    end

    def set_comment
      @comment=Comment.find(params[:id])
    end

    def require_permission
      if current_user != Comment.find(params[:id]).user
        redirect_to items_path, notice: "You cant do this!"
      end
    end
end
