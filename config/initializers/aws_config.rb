require 'aws-sdk'

Aws.config.update({
                      region: Settings.aws.region,
                      credentials: Aws::Credentials.new(Settings.aws.access_key_id,
                                                        Settings.aws.secret_access_key)
                  })


$rekognition = Aws::Rekognition::Client.new()