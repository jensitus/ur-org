class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :html, :js

  def index
    @user_groups = current_user.groups
    respond_with(@groups)
    @public_groups
  end

  def show
    @micropost = Micropost.new # current_user.microposts.build(micropost_params)
    @microposts = @group.microposts.reorder(id: :asc)
    @placeholder = 'Schreib der Gruppe, was dir am Herzen liegt'
    @users = User.all
    # respond_with(@group)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @group = Group.new
    respond_with(@group)
  end

  def edit
  end

  def create
    @group = current_user.groups.build(group_params)
    @group.update(private: true)
    if @group.save
      GroupMembership.create!(group_id: @group.id, user_id: current_user.id)
      GroupMaintainer.create!(group_id: @group.id, user_id: current_user.id)
      flash[:success] = '<b>cool</b>'.html_safe
      redirect_to groups_path
    else
      flash[:alert] = '<b>unfortunately ...</b>'
    end
  end

  def add_user_to_group
    user_id = add_user_params['add_user'].to_i
    group_id = add_user_params['group_id'].to_i
    @user = User.find user_id
    @group = Group.find group_id
    begin
      GroupMembership.create!(group_id: group_id, user_id: user_id)
    rescue ActiveRecord::RecordNotUnique
      flash[:warning] = '<b>Yeah, this user is already a member of this group</b>'.html_safe
      logger.warn "Someone tried to add a user twice. We couldn't allow that behavior."
    end
  end

  def update

  end

  def destroy
  end

  def membership

  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end

  def micropost_params

  end

  def add_user_params
    params.permit(:add_user, :group_id)
  end

  def group_id_params
    params.permit(:group_id)
  end

end
