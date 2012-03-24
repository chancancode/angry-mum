class Alert < ActiveRecord::Base
  belongs_to :user
  
  validates :reason, presence: true
  validates :start, presence: true
  validates :fallback_name, presence: true
  validates :fallback_phone, presence: true
  
  
  def fallback_phone=(value)
    super(value)
    normalise_fallback_phone
  end
  
  def normalise_fallback_phone
    self.normalised_phone_normalised = fallback_phone.gsub(/[^0-9]/, '').gsub(/^1/, '')
  end
  
end
