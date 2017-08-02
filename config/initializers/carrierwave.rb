CarrierWave.configure do |config|
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.secrets.aws[:access_key_id],
      aws_secret_access_key: Rails.application.secrets.aws[:secret_access_key],
      region: Rails.application.secrets.aws[:region]
  }

  config.fog_directory  = Rails.application.secrets.aws[:bucket]
  config.cache_storage = :fog

  config.root = Rails.root.join('tmp')
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end