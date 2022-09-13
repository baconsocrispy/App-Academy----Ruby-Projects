class User < ApplicationRecord
  validates :username, :password_digest, presence: true
  validates :username, uniqueness: true

  def password=(password)
    self.password_digest = Bcrypt::Password.create(password)
  end
  def is_password?(password)
    Bcrypt::Password.new(self.password_digest).is_password?(password)
  end
end
