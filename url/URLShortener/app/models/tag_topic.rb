class TagTopic < ApplicationRecord
  validates :topic, :user_id, :shortened_url_id, presence: true

  
end