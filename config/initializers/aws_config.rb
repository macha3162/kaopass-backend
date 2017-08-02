require 'aws-sdk'

Aws.config.update({
                      region: Rails.application.secrets.aws[:region],
                      credentials: Aws::Credentials.new(Rails.application.secrets.aws[:access_key_id],
                                                        Rails.application.secrets.aws[:secret_access_key])
                  })


$rekognition = Aws::Rekognition::Client.new()