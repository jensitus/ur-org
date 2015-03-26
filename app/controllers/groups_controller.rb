class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :html, :js

  def index
    @groups = Group.all
    respond_with(@groups)
  end

  def show
    @micropost = Micropost.new # current_user.microposts.build(micropost_params)
    @microposts = @group.microposts.page(params[:page]).per(8)
    @placeholder = 'Schreib der Gruppe, was dir am Herzen liegt'
    respond_with(@group)
  end

  def new
    @group = Group.new

    respond_with(@group)
  end

  def edit
  end

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      #byebug
      GroupMembership.create!(group_id: @group.id, user_id: current_user.id)
      GroupMaintainer.create!(group_id: @group.id, user_id: current_user.id)
      flash[:success] = '<b>cool</b>'.html_safe
      redirect_to groups_path
    else
      flash[:alert] = '<b>unfortunately ...</b>'
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

end
