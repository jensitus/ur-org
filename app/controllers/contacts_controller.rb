class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :show, :update, :destroy]

  respond_to :html

  def index
    if current_user.admin?
      @contacts = Contact.all
      respond_with(@contacts)
    else
      redirect_to request.referrer || root_url
    end
  end

  def show
    if current_user.admin?
      respond_with(@contact)
    else
      redirect_to request.referrer || root_url
    end
  end

  def new
    @contact = Contact.new
    respond_with(@contact)
  end

  def edit
    if current_user.try(:admin?)
    else
      redirect_to request.referrer || root_url
    end
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.confirmation(@contact).deliver
      ContactMailer.inquiry(@contact).deliver
      flash[:success] = 'We got a message from you, we appreciate that!!'
      redirect_to root_url
    else
      respond_with(@contact)
    end
  end

  def update
    if current_user.admin?
      @contact.update(contact_params)
      respond_with(@contact)
    else
      redirect_to request.referrer || root_url
    end
  end

  def destroy
    if current_user.admin?
      @contact.destroy
      respond_with(@contact)
    else
      redirect_to request.referrer || root_url
    end
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end
end
