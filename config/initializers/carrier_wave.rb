require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'
require 'carrierwave/storage/aws'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage    = :aws
    config.aws_bucket = Rails.application.credentials.AWS_bucket
    # config.aws_acl    = 'public-read'

    config.aws_credentials = {
      access_key_id:     Rails.application.credentials.AWS_access_key_id,
      secret_access_key: Rails.application.credentials.AWS_secret_access_key,
      region:            Rails.application.credentials.AWS_region
    }
  end
end




