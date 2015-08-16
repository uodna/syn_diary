class Diary < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  enum status: {closed: 0, opened: 1}

  validates :date, presence: true
  validates :diary, presence: true
  validates :status, presence: true

  default_scope -> { order('date DESC') }
  scope :find_date_and_user_id, -> (date, user_id) { where("date = ? and user_id = ?",  date, user_id) }

  def own?(user)
    self.user_id == user.id
  end

  def Diary.status_label
    status_label = { "非公開" => :closed, "公開" => :opened }
  end
end
