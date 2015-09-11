Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :google_oauth2, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  # provider :google_oauth2, "AIzaSyAOoxkTzQNRSVd6KYrSN6BA1SfKV1Imi10", 456
  provider :google_oauth2, "337325784121-eq2ir8s1gm4kqe7ekh38m1j0raosrqc8.apps.googleusercontent.com", "ReUHPs372aW_QU4k4PhrSB-e"
end