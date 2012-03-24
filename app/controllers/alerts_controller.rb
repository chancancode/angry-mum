class AlertsController < ApplicationController
  before_filter :login_required, :except => [:show]
  
  def index
    @alerts = current_user.alerts.all
    
    @pending_alerts = current_user.alerts.pending.all
    @successful_alerts = current_user.alerts.successful.all
    @failed_alerts = current_user.alerts.annoying.all

    @alert = current_user.alerts.new
  end
  
  def new
    @alert = current_user.alerts.new
  end
  
  def edit
    @alert = current_user.alerts.find params[:id]
  end
  
  def show
    @alert = Alert.find(params[:id])
    
    respond_to do |format|
      if @alert        
        response = Twilio::TwiML::Response.new do |r|
          r.Say "Hi #{@alert.fallback_name}, " +
                "#{@alert.user.name} needs to wake up for #{@alert.reason} right about now, " +
                "but it looks like #{@alert.user.name} is still sleeping... can you help?", :voice => 'man'
          r.Dial @alert.user.normalised_phone, :callerId => TWILIO_CALLER_ID
          r.Say "Thank you for your help #{@alert.fallback_name}, have a nice day!", :voice => 'man'
        end
        
        Rails.logger.info response.text
        
        format.xml { render :text => response.text }
      else
        raise "Not found!"
      end
    end
  end
  
  def create
    @alert = current_user.alerts.new(params[:alert])
    
    if @alert.save
      redirect_to action: 'index'
    else
      render action: 'new'
    end
  end
  
  def update
    @alert = current_user.alerts.find params[:id]

    if @alert.update_attributes params[:alert]
      redirect_to action: 'index'
    else
      render action: 'edit'
    end
  end
  
end
