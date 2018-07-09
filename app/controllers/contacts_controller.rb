class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :show, :update, :destroy]
  before_action :require_admin, only: [:index, :show, :edit, :update, :destroy]

  respond_to :html

  def index
    @contacts = Contact.all
    respond_with(@contacts)
  end

  def show
    respond_with(@contact)
  end

  def new
    @contact = Contact.new
    respond_with(@contact)
  end

  def edit
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      #ContactMailer.confirmation(@contact).deliver_later
      #ContactMailer.inquiry(@contact).deliver_later
      flash[:success] = 'We got a message from you, we appreciate that!!'
      redirect_to root_url
    else
      respond_with(@contact)
    end
  end

  def update
    @contact.update(contact_params)
    respond_with(@contact)
  end

  def destroy
    @contact.destroy
    respond_with(@contact)
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end

  def require_admin
    if !current_user.try(:admin?)
      flash[:alert] = 'muss das sein?'
      redirect_to request.referrer || root_url
    end
  end

end
