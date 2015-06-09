class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_admin, only: [:index, :show, :edit, :new]

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
    mentions = Mention.get_the_mention(@comment.body)
    if @comment.save
      @answer = Answer.create!(:micropost_id => answer_params,
                               :comment_id => @comment.id)
      Mention.mention_it(mentions, @comment)
      #flash[:success] = '<b>cool, ein neuer kommentar</b>'.html_safe
    else
      @feed_items = []
      render 'static_pages/home'
      flash[:alert] = '<b>that was an absolute disaster</b>'.html_safe
    end
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
      p[:micropost_id].to_i
    end

  def require_admin
    if !current_user.admin?
      flash[:alert] = '<b>finger weg!!</b>'.html_safe
      redirect_to request.referrer || root_url
    end
  end

end
