class User < ActiveRecord::Base
  has_many :task_lists

  has_secure_password

  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
