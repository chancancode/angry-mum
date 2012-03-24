class AlertsController < ApplicationController
  before_filter :login_required
  
  def index
    @alerts = current_user.alerts.all
    @alert = current_user.alerts.new
  end
  
  def new
    @alert = current_user.alerts.new
  end
  
  def create
    @alert = current_user.alerts.new(params[:alert])
    
    if @alert.save
      redirect_to action: 'index'
    else
      render action: 'new'
    end
  end
  
end
