OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
            '756813753673-hqcgsmbjea1rop3rqu74tqgvr394j3b5.apps.googleusercontent.com', 'DtVFvCnp91o4_jLWSByX_fuz',
            {
              :name => "google",
              :scope => "email, profile, plus.me, http://gdata.youtube.com",
              :prompt => "select_account",
              :image_aspect_ratio => "square",
              :image_size => 50
            }
end