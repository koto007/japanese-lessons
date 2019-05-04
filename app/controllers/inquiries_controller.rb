class InquiriesController < ApplicationController
  before_action :require_user_admin, only: [:index]
  def index
    @inquiry = Inquiry.new
    @inquiries = Inquiry.all.order('created_at DESC')
    #.feed_inquiries.order('created_at DESC').page(params[:page])
  end
  
  def show
   @inquiry = Inquiry.find(params[:id])
   
  end

  def new
    @inquiry = Inquiry.new
  end
  
  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      flash[:success] = 'Votre mail a été envoyé ! Je vous répondrons au plus vite.'
      redirect_to root_url
    else 
      flash.now[:danger] = "Votre message n'a pas été envoyé, réessayez."
      render :new
    end
  end

  private 
  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :message)
  end
end
