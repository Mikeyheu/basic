if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS', # required
      :aws_access_key_id      => 'AKIAIC64N6SHUP3XIEBA', # required
      :aws_secret_access_key  => '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',  # required
    }
    config.fog_directory  = 'mheutest'                     # required
    config.fog_public     = false                                   # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  end
end
