class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :index, :new, :destroy, :update, :edit]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:index, :new]
  before_action :require_user, only: :edit
  # after_action :require_redirect, only: :update

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
    puts '+++++++++++++++++++++++++++++++++++++++++'
    puts @comment.inspect
    puts '+++++++++++++++++++++++++++++++++++++++++'
    mentions = Mention.get_the_mention(@comment.body)
    if @comment.save
      if photo_or_answer_params[:photo_or_answer] == 'photo'
        @photo_comment = PhotoComment.create!(photo_id: photo_id, comment_id: @comment.id)
        Mention.mention_it(mentions, @comment)
        @photo_comment.create_activity :create, owner: current_user
      else
        @answer = Answer.create!(:micropost_id => answer_params,
                                 :comment_id => @comment.id)
        Mention.mention_it(mentions, @comment)
        @comment.create_activity :create, owner: current_user
      end

      #flash[:success] = '<b>cool, ein neuer kommentar</b>'.html_safe
    else
      @feed_items = []
      render 'static_pages/home'
      flash[:alert] = '<b>that was an absolute disaster</b>'.html_safe
    end
  end

  def update
    #respond_to do |format|
      if current_user == @comment.user
        if @comment.update(comment_params)
          puts
          puts 'redirect_to'
          puts
          redirect_to request.referer
          #redirect_to user_post_path(slug: @comment.micropost.user.slug, id: @comment.micropost.id)
          # respond_with @comment.micropost
          #format.html { redirect_to @comment, notice: 'successfully' }
          #format.json { render :show, status: :ok, location: @comment }
        else
          redirect_to root_path
          #format.html { render :edit }
          #format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      else
        redirect_to root_url
      end
    #end
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

  def photo_or_answer_params
    params.require(:comment).permit(:photo_or_answer)
  end

  def photo_id
    params.require(:comment).permit(:photo_id)[:photo_id].to_i
  end

  def answer_params
    p = params.require(:comment).permit(:micropost_id)
    p[:micropost_id].to_i
  end

  def require_admin
    if !current_user.admin?
      flash[:alert] = 'finger weg!!'.html_safe
      redirect_to root_url
    end
  end

  def require_user
    if current_user != @comment.user
      flash[:alert] = 'immer wieder deppat'.html_safe
      redirect_to root_url
    end
  end

  # def require_redirect
  #   redirect_to root_url
  # end

end
