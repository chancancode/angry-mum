class Alert < ActiveRecord::Base
  belongs_to :user
  
  validates :reason, presence: true
  validates :start, presence: true
  validates :fallback_name, presence: true
  validates :fallback_phone, presence: true
  
end
