class User < ActiveRecord::Base
  attr_reader :password
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}

  has_many :goals

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
