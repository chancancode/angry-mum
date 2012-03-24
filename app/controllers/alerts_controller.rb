class AlertsController < ApplicationController
  before_filter :login_required
  
  def index
    @alerts = current_user.alerts.all
    @alert = current_user.alerts.new
  end
  
  def new
    @alert = current_user.alerts.new
  end
  
  def edit
    @alert = current_user.alerts.find params[:id]
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
