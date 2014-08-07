require "date"

class Task < ActiveRecord::Base
  belongs_to :task_list
  belongs_to :user

  validates :description, presence: {
    :message => "Your task could not be created"
  }

  validates :assigned_to, presence: {
    :message => "Task must have user assigned"
  }

  validate :date_cannot_be_past

  def date_cannot_be_past
    if date < Date.today
      errors[:date] = "Please select a future date"
    end
  end

end