class Interview < ApplicationRecord
  belongs_to :user
  default_scope -> { order(interview_date: :asc) }
  validates :user_id, presence: true
  validates :interview_date, presence: true
  enum interview_condition: { unconfirmed: 0, approval: 1, denial: 2 }

  def datetime
    return if interview_date.blank?
    interview_date.strftime('%Y年%m月%d日 %H:%M')
  end
end
