class Project < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_and_belongs_to_many :users
  has_many :tasks

  validates :title, presence: true, uniqueness: {scope: :owner }
  
  def is_owner?(user)
    self.owner_id == user.id
  end

  def is_member?(user)
    self.users.include? user
  end
end
