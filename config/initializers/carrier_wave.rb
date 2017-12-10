# if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
        # Configuration for Amazon AWS
        :provider => 'AWS',
        :region => 'eu-central-1',
        :aws_access_key_id => ENV['S3_ACCESS_KEY'], # Rails.application.secrets.s3_access_key,      # ,ENV['S3_ACCESS_KEY']
        :aws_secret_access_key => ENV['S3_SECRECT_KEY'] # Rails.application.secrets.s3_secret_key   # ENV['S3_SECRECT_KEY']
    }
    config.fog_directory = ENV['S3_BUCKET'] # Rails.application.secrets.s3_bucket              # ENV['S3_BUCKET']
  end
# end