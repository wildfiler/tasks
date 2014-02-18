class Task < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  belongs_to :project

  validates :title, presence: true
  validates :owner, presence: true
end
