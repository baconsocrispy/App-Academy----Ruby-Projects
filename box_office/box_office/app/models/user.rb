class User < ApplicationRecord
  before_validation :ensure_session_token

  validates :first_name, :last_name, presence: true
  validates :username, :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8, allow_nil: true }
  validates :password_digest, presence: { message: 'Password can\'t be blank' }
  validates :session_token, presence: true, uniqueness: true

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    password_match?(password) ? user : nil
  end
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def password_match?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end
  
  private
  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64(16)
  end
end
