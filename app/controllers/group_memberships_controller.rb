class GroupMembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.find_by(params.require(:group_membership).permit[:group_id])
    GroupMembership.create!(gm_params)
    respond_to do |format|
      format.html { redirect_to @group }
      format.js
    end
  end

  def destroy
    @group = Group.find_by(params[:group_id])
    GroupMembership.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to @group }
      format.js
    end
  end

  private

  def gm_params
    params.require(:group_membership).permit(:user_id, :group_id)
  end

end
