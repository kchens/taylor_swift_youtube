class User < ActiveRecord::Base
  include BCrypt

  has_many :votes
  has_many :videos, through: :votes

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, :email, :username, :password_hash, presence: true
  validates :name, :email, :username, length: { maximum: 20, minimum: 3}
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

  def self.get_api_state
    @state
  end

end
