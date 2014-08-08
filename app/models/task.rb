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

  def self.filtered_tasks(params)
    start_date = Date.parse(params[:date][:start])
    end_date = Date.parse(params[:date][:end])
    where(
      "date >= :start_date AND date <= :end_date AND user_id = :user_id",
      start_date: start_date,
      end_date: end_date,
      user_id: params[:user_id]
    )
  end

end