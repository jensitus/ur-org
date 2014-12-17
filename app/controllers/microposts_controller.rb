class MicropostsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy, :update, :edit]
  before_action :correct_user, only: :destroy
  before_action :set_micropost, only: [:edit, :update, :destroy, :show]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'jesus christ, you did it!!'
      redirect_to request.referrer || root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

  def update
    # respond_to do |format|
      if @micropost.update(micropost_params)
        #format.html { redirect_to request.referrer || root_url, flash[:success] = 'yeah!!' }
        #format.json
        flash[:success] = 'yeah!!'
        redirect_to :root
      else
        flash[:alert] = 'so nicht'
        render 'static_pages/home'
      end
    # end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Oh no, it's deleted"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

  def set_micropost
    @micropost = Micropost.find(params[:id])
  end

end
