class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :html, :js

  def index
    @comments = Comment.all
    respond_with(@comments)
  end

  def show
    respond_with(@comment)
  end

  def new
    @comment = Comment.new
    respond_with(@comment)
  end

  def edit
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = 'cool'
      @answer = Answer.create!(:micropost_id => answer_params,
                               :comment_id => @comment.id)
    else
      @feed_items = []
      render 'static_pages/home'
    end
    #end
    # respond_with(@comment)
  end

  def update
    @comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    @comment.destroy
    respond_with(@comment)
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end

    def answer_params
      p = params.require(:comment).permit(:micropost_id)
      #byebug
      p[:micropost_id].to_i
    end
end
