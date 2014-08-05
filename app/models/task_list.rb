class TaskList < ActiveRecord::Base
  has_many :tasks
  validates :name, presence:
    {message: "Your task list could not be created"}
end