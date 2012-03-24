class Message < ActiveRecord::Base
  def self.question(to)
    self.create({
      delivered: false,
      incoming: false,
      sid: nil,
      to: to,
      from: TWILIO_CALLER_ID,
      body: "1+1 equals... A. 1 ; B. 2 ; C. 3"
    })
  end
  
  def deliver
    return if self.incoming || self.delivered
    
    client = Twilio::REST::Client.new TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN
    response = client.account.sms.messages.create(
      :from => self.from,
      :to => self.to,
      :body => self.body
    )
    
    self.sid = response.sid
    self.delivered = true
    self.save
  end
end
