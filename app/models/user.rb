class User < ActiveRecord::Base
  ROLES = %w(admin user)

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :role, presence: true, inclusion: {in: ROLES}
  validates :email, presence: true
  validates :name, presence: true

  has_many :tasks, foreign_key: :owner_id
  has_and_belongs_to_many :projects  

  ROLES.each do |role|
    define_method "is_#{role}?" do
      self.role == role
    end
  end

  def own_projects
    self.projects.where(projects:{owner_id: self.id})
  end
end
