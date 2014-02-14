class Task < ActiveRecord::Base
  belongs_to :owner, class_name: :user

  validates :title, presence: true
end
