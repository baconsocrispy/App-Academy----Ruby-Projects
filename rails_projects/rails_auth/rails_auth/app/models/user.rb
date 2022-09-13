class User < ApplicationRecord
  before_validation :ensure_session_token
  
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: { message: 'Password can\'t be blank' }
  validates :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 , allow_nil: true }

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_By(username: username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end
  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end
  def password=(pass)
    @password = pass
    self.password_digest = BCrypt::Password.create(pass)
  end
  private
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end  
  def is_password?(pass)
    BCrypt::Password.new(self.password_digest).is_password?(pass)
  end
end
