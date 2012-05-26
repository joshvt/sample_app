class Micropost < ActiveRecord::Base
  attr_accessible :content
  validates  :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  belongs_to :user

  default_scope order: 'microposts.created_at DESC'

  def self.from_users_followed_by(user)
    select_followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{select_followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
end
