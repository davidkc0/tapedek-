class User < ActiveRecord::Base
  acts_as_messageable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  validates :username, presence: true, length: { in: 4..22 },
            uniqueness: {case_sensitive: false}

  has_many :posts
  has_many :reports ## Reported dead links
  has_many :authentications, :dependent => :destroy 

  def admin?
    false
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def password_required?
    if self.authentications.any?
      false
    else
      super
    end
  end 

  def apply_omniauth(omniauth)
    case omniauth['provider']
    when "google_oauth2"
      self.email = omniauth['info']['email']
      self.username = omniauth['info']['email'].split("@")[0].gsub(".", "_")
    when "facebook"
      self.email = omniauth['info']['email']
      self.username = omniauth['info']['email'].split("@")[0].gsub(".", "_")
    end  
    self.encrypted_password = Devise.friendly_token[0,20]
    auth_attrs = { provider: omniauth['provider'], uid: omniauth['uid'] }
    authentications.build(auth_attrs)
  end

  def name
    username
  end

  def mailboxer_email(object)
    nil
  end
    
end
