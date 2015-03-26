class GroupMembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.find(params[:group_membership][:group_id])
    GroupMembership.create!(gm_params)
    redirect_to group_url(@group)
  end

  def destroy
    gm = GroupMembership.find(params[:id])
    @group = Group.find gm.group_id
    gm.destroy
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
