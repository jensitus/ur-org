class LikesController < ApplicationController

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @micropost_id = params[:micropost_id]
    current_user.like! @micropost
    @likes = @micropost.likers(User)
    respond_to do |format|

      format.html { redirect_to @micropost }
      format.js
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost_id = params[:id]
    current_user.unlike! @micropost
    @likes = @micropost.likers(User)
    respond_to do |format|
      format.html { redirect_to @micropost }
      format.js
    end
  end

  private

  def m_params
    params.permit(:micropost_id)
  end

end
