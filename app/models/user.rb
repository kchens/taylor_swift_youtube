class User < ActiveRecord::Base
  include BCrypt

  has_many :votes
  has_many :videos, through: :votes

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :first_name, :email, :username, :password_hash, presence: true
  validates :first_name, :email, :username, length: { minimum: 3}
  validates :email, format: { with: VALID_EMAIL_REGEX }

  before_save { |user| user.email = email.downcase }

  def authenticate(password)
    self.password == password
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end


  def self.create_api_state
    @state = SecureRandom.hex
  end

  def self.exists?(id)
    User.find_by(fb_uuid: id) ? true : false
  end

  def self.create_with_facebook(info)
    new_user = self.create(
      fb_uuid:        info["id"],
      first_name:     info["first_name"],
      last_name:      info["last_name"],
      username:       info["email"],
      email:          info["email"],
      password_hash:  SecureRandom.hex,
      access_token:   info["access_token"],
      expires:        info["expires"]
    )
    pp new_user.errors.full_messages
  end

end
