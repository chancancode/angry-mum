class User < ActiveRecord::Base
  validates :name, presence: true
  validates :phone, format: { with: /^\+?[0-9\-\ \.]{7,10}/ }
  
  has_many :alerts, dependent: :destroy
  
  def phone=(value)
    super(value)
    normalise_phone
  end
  
  def normalise_phone
    self.normalised_phone = phone.gsub(/[^0-9]/, '').gsub(/^1/, '')
  end
end
