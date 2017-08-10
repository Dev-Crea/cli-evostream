# frozen_string_literal: true

Evostream::Service.configuration do |config|
  # URL to EvoStream for share video to final user
  config.uri_in       = 'http://192.168.203.116:7777'

  # URL to EvoStream for sending request to this API
  config.uri_out      = 'http://192.168.203.116:80'

  # Use environment for this gem. Choose between :
  # - development   : Write in log and Send request to evoStream
  # - test          : Write in Log
  # - production    : Send request to EvoStream
  config.environment  = :production

  config.web_root = ''
  config.name = ''
  config.model = ''
  config.model_id = ''
end
