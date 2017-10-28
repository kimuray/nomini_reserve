CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_S3_ADMIN_ID'],
    aws_secret_access_key: ENV['AWS_S3_ADMIN_SECRET'],
    region: 'ap-northeast-1'
  }

  config.fog_attributes = { 'Cache-Control' => 'public, max-age=86400' }

  if Rails.env.staging? || Rails.env.production?
    config.fog_directory = ENV['S3_DIRECTORY']
    config.asset_host = ENV['S3_ENDPOINT']
  end
end
