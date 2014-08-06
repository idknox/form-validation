class TaskList < ActiveRecord::Base
  has_many :tasks
  validates :name, presence:
    {message: "Your task list could not be created"}

  def tasks_for_user(user_id)
    tasks.where(
      :user_id => user_id,
      :complete => false
    ).order(:date)
  end
end