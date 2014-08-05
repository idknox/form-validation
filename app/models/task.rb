require "date"

class Task < ActiveRecord::Base
  validates :description, :presence => {
    :message => "Your task could not be created"
  }

  def create_date(params)
    Date.parse(params["date(1i)"] + "-" + params["date(2i)"] +
                 "-" + params["date(3i)"])
  end
end