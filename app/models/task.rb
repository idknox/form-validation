require "date"

class Task < ActiveRecord::Base
  belongs_to :task_list

  validates :description, :presence => {
    :message => "Your task could not be created"
  }

  validate :date_cannot_be_past

  def create_date(params)
    Date.civil(
      params["date(1i)"].to_i,
      params["date(2i)"].to_i,
      params["date(3i)"].to_i
    )
  end

  def date_cannot_be_past
    if date.past?
      errors.add(:date, "Please select a past date")
    end
  end

end