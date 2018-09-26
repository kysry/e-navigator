class Interview < ApplicationRecord
  belongs_to :user
  default_scope -> { order(interview_date: :asc) }
  validates :user_id, presence: true
  validates :interview_date, presence: true
  enum interview_condition: { Unconfirmed: 0, Approval: 1, Denial:2 }
end
