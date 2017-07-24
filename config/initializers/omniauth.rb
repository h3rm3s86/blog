Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.google_client_id, Rails.application.secrets.google_client_secret,
    { scope: 'email,profile',
      provider_ignores_state: true
    }
  provider :facebook, "124369461503996", "deade7dd1ca7c7fbb3e353e17d562569",
    {
      #site: 'https://graph.facebook.com/v2.9',
      #authorize_url: "https://www.facebook.com/v2.9/dialog/oauth",
      provider_ignores_states: true
    }
  #OmniAuth.config.full_host = Rails.env.production? ? 'https://domain.com' : 'http://localhost:3000'
end
