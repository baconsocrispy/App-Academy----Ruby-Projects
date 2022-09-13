class ShortenedUrl < ApplicationRecord
  validates :long_url, :short_url, :user_id, presence: true
  validates :short_url, uniqueness: true

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )
  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :shortened_url_id,
    primary_key: :id
  )
  has_many :visitors, through: :visits, source: :user

  def self.random_code
    code = SecureRandom::urlsafe_base64
    until ShortenedUrl.exists?(:short_url => code) == false
      code = SecureRandom::urlsafe_base64
    end
    code
  end
  def self.create!(user, long_url)
    short_url = ShortenedUrl.new
    short_url.long_url = long_url
    short_url.user_id = user.id
    short_url.short_url = ShortenedUrl.random_code
    short_url.save!
    short_url
  end
  def num_clicks
    Visit.all.select { |v| v.shortened_url_id == self.id }.count
  end
  def num_uniques
    Visit.all.select(:user_id).distinct.count
  end
  def num_recent_uniques
    Visit.all.select(:user_id).where(self.created_at >= Time.now - 10.minutes).distinct.count
  end

end