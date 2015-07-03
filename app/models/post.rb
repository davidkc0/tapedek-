class Post < ActiveRecord::Base
belongs_to :user
	acts_as_votable

	validates :title, presence: true, 
			length: {minimum: 4, maximum: 45}

	validates :video_url, uniqueness: true

	validates :video_url, presence: true

	def self.highest_voted
    self.order(:cached_votes_up)
  end
end
