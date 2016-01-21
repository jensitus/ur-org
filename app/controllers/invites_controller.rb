class InvitesController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_invite

  def new
    @invite = Invite.new
    iv = current_user.invite_counts.where(:deleted => false).count
    @invite_count = 5 - iv
  end

  def create
    @invite = current_user.invites.build(invite_params)
    puts '+++++++++++++++++++++++++++++++++++++++++++++++'
    puts @invite.inspect
    puts '+++++++++++++++++++++++++++++++++++++++++++++++'
    if @invite.save
      @invite_count = InviteCount.create!(
          :user_id => current_user.id,
          :invite_id => @invite.id
      )
      flash[:success] = 'they will never be invited'
    else
      flash[:warning] = 'maybe this emailaddress is already invited or something different is wrong'
    end
    redirect_to request.referrer || root_path
  end

  def dele
    current_user.invite_counts.where( :deleted => false ).each do |ivc|
      ivc.update(:deleted => true)
    end
    redirect_to request.referrer || root_path
  end

  private

  def set_invite
    @invite = Invite.find(params[:id])
  end

  def invite_params
    params.require(:invite).permit(:email, :letter)
  end

  def invite_count_params
    params.require(:invite).permit(:user_id)
  end

end
