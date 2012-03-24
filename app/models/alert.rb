class Alert < ActiveRecord::Base
  belongs_to :user
  
  validates :reason, presence: true
  validates :start, presence: true
  validates :fallback_name, presence: true
  validates :fallback_phone, presence: true

  scope :pending, conditions: { sid: nil }
  scope :successful, conditions: { sid: 'CHECKED' }
  scope :annoying, conditions: "sid IS NOT NULL AND sid != 'CHECKED'"

  def sent?
    sid.present?
  end

  def call(url)    
    client = Twilio::REST::Client.new TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN
    response = client.account.calls.create(
      :from => TWILIO_CALLER_ID,
      :to => self.fallback_phone_normalised,
      :url => url,
      :method => 'GET'
    )
    
    Rails.logger.info "Made phone call to #{self.fallback_phone_normalised}, response: #{response.inspect}"
    
    self.sid = response.sid
    self.save
  end
  
  def fallback_phone=(value)
    super(value)
    normalise_fallback_phone
  end
  
  def normalise_fallback_phone
    self.fallback_phone_normalised = fallback_phone.gsub(/[^0-9]/, '').gsub(/^1/, '')
  end
end
