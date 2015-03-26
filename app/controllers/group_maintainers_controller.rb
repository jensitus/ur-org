class GroupMaintainersController < ApplicationController
  before_action :authenticate_user!

  def create

  end

  def destroy

  end

  private

  def gm_params
    params.require(:group_maintainers).permit(:user_id, :group_id)
  end

end
