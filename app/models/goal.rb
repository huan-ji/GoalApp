class Goal < ActiveRecord::Base
  validates :description, :goal_type, :completed, :user_id, presence: true

  belongs_to :user
  has_many :goal_comments
end
