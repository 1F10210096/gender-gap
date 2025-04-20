class ImageProcessingJob < ApplicationJob
  queue_as :default
  require 'aws-sdk-s3'
  def perform(key)
    return if key.blank?

    s3 = Aws::S3::Resource.new(
      region: ENV['AWS_REGION'],
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    )

    bucket = s3.bucket(ENV['AWS_BUCKET_NAME'])

    url = bucket.object(key).presigned_url(:get, expires_in: 86400) # 24h

    Rails.cache.write("image_presigned_url:#{key}", url, expires_in: 12.hours)
  rescue => e
    Rails.logger.error("ImageProcessingJob failed for key=#{key}: #{e.message}")
  end
end
