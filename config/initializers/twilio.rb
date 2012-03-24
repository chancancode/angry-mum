require 'yaml'

begin
  config = YAML::load(File.open(File.join(Rails.root,'config','twilio.yml')))

  TWILIO_ACCOUNT_SID = config['account_sid']
  TWILIO_AUTH_TOKEN  = config['auth_token']
  TWILIO_CALLER_ID   = config['caller_id']
rescue
  # Apparently the logger is not available in initializers, so ignoring
end

# Heroku fall back

TWILIO_ACCOUNT_SID ||= ENV['TWILIO_ACCOUNT_SID']
TWILIO_AUTH_TOKEN  ||= ENV['TWILIO_AUTH_TOKEN']
TWILIO_CALLER_ID   ||= ENV['TWILIO_CALLER_ID']