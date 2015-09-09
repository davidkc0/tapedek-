class Post < ActiveRecord::Base
  include UrlHelp

  PROVIDERS = %w[vimeo youtube vine instagram twitch gif]

  belongs_to :user
	acts_as_votable

	validates :title, presence: true, 
			length: {minimum: 4, maximum: 55}

	validates :video_url, uniqueness: true

	validates :video_url, presence: true

  validates :provider, inclusion: { in: PROVIDERS,
    message: "This URL is not in our list of accepted domains. Please user the following domains: #{PROVIDERS.map{|p| p.titleize}.join(", ")}" }

  def video_url=(url)
    set_provider(url)
    url = UrlHelp::cut_before_domain(url) if !UrlHelp::is_gif?(url)
    super
  end

  def get_domain(url)
    url = "gif" if UrlHelp::is_gif?(url)
    url = UrlHelp::cut_before_domain(url)
    domain = url.split(".")[0]
  end 

  def set_provider(url)
    domain = get_domain(url) 
    if PROVIDERS.include? domain
      provider = domain
    else
      provider = nil
    end
    update_attribute(:provider, provider)
  end

	def self.highest_voted
    self.order(:cached_votes_up)
  end
end
