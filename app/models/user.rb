class User < ActiveRecord::Base
  has_many :task_lists
  has_many :tasks

  has_secure_password

  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  def self.get_names
      all.to_a.map { |user| user.name }
  end
end
