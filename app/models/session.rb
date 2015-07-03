class Session < ActiveRecord::Base
	acts_as_voter
	request.remote_ip
end