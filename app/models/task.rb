require "date"

class Task < ActiveRecord::Base
  belongs_to :task_list

  validates :description, presence: {
    :message => "Your task could not be created"
  }

  validates :user, presence: {
    :message => "Task must have user assigned"
  }

  validate :date_cannot_be_past

  def date_cannot_be_past
    if date < Date.today
      errors[:date] = "Please select a future date"
    end
  end

  def create_date(params)
    Date.civil(
      params["date(1i)"].to_i,
      params["date(2i)"].to_i,
      params["date(3i)"].to_i
    )
  end
end