class Comment < ActiveRecord::Base
  belongs_to :diary
  belongs_to :user

  validates :user_id, presence: true
  validates :diary_id, presence: true
  validates :comment, presence: true

  default_scope -> { order('comments.created_at DESC') }

  def created_at_jst
    created_at_jst = self.created_at.in_time_zone('Tokyo')
  end
end