class User < ActiveRecord::Base
  include BCrypt

  has_many :votes
  has_many :videos, through: :votes

  # def authenticate(password)
  #   self.password = password
  # end

  # def password
  #   @password ||= Password.new(password_hash)
  # end

  # def password_hash=(new_password)
  #   @password = Password.create(new_password)
  #   self.password_hash = @password
  # end

end
