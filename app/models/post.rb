class Post < ActiveRecord::Base
  include UrlHelp

  PROVIDERS = %w[vimeo youtube vine instagram twitch gif]

  belongs_to :user
  has_many :reports, as: :reportable
	acts_as_votable
  acts_as_commentable
  acts_as_taggable

	validates :title, presence: true, 
			length: {minimum: 2, maximum: 60}

	validates :video_url, presence: true, uniqueness: true

  validates :provider, inclusion: { in: PROVIDERS,
    message: "This URL is not in our list of accepted domains. Please user the following domains: #{PROVIDERS.map{|p| p.titleize}.join(", ")}" }

  def video_url=(url)
    url = UrlHelp::clean_url(url, get_domain(url))
    set_provider(url)
    super
  end

  def get_domain(url)
    return nil unless url.present?
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
    self.provider = provider
  end

	def self.highest_voted
    self.order(:cached_votes_up)
  end
end
