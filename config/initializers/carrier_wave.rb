# if Rails.env.production?
#   CarrierWave.configure do |config|
#     config.fog_credentials = {
#       :provider => 'AWS',
#       :aws_access_key_id => ENV['S3_ACCESS_KEY'],
#       :aws_secret_access_key => ENV['S3_SECRET_key']
#     }
#     config.fog_directory = ENV['S3_Bucket']
#   end
# end

if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage    = :aws
    config.aws_bucket = Rails.application.credentials.AWS_bucket
    config.aws_acl    = 'public-read'

    config.aws_credentials = {
      access_key_id:     Rails.application.credentials.AWS_access_key_id,
      secret_access_key: Rails.application.credentials.AWS_secret_access_key,
      region:            Rails.application.credentials.AWS_region
    }
  end
end




