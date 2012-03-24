class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new params[:user]
    
    # Do we recnognise this number?
    if @user.valid?
      user = User.where(normalised_phone: @user.normalised_phone)
      if user.present?
        current_user = user
        redirect_to alerts_path
        return
      end
    end

    if @user.save
      current_user = @user
      redirect_to alerts_path
    else
      render action: 'new'
    end
  end
end
