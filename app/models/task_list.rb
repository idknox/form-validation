class TaskList < ActiveRecord::Base
  has_many :tasks
  belongs_to :user

  validates :name, presence:
    {message: "Your task list could not be created"}

  def tasks_for_user(user_id)
    tasks.where(
      :user_id => user_id,
      :completed => false
    ).order(:date)
  end
end