class MessagesController < ApplicationController 
  # GET /messages
  # GET /messages.json
  def index    
    @messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # POST /messages
  # POST /messages.json
  def create    
    @message = Message.new({
      incoming: true,
      sid: params['SmsSid'],
      to: params['To'],
      from: params['From'],
      body: params['Body']
    })
    
    respond_to do |format|
      if @message.save
        
        reply = (@message.body.downcase.strip == 'b') ? 'Have a nice day, honey!' : 'Uh oh, we are calling mum...'
        
        response = Twilio::TwiML::Response.new do |r|
          r.Sms reply
        end
        
        Rails.logger.info response.text
        
        user = User.normalise_and_find(params['From'])
        
        if user
          alert = user.alerts.where(:sid => nil).order("start asc").limit(1)
          
          if alert.length == 1
            alert = alert.first
            
            if @message.body.downcase.strip == 'b'
              alert.sid = "CHECKED"
              alert.save
            else
              alert.delay.call(alert_url(alert, :format => :xml))
            end
          end
        end
        
        format.xml { render :text => response.text }
      else
        raise "Can't save!"
      end
    end
  end
end
