class AnswersController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def show

  end

  def new

  end

  def create
    @answer = current_user.microposts.build(micropost_params)
    if @answer.save
      flash[:success] = 'jesus christ, you did it!!'
      redirect_to request.referrer || root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

end
