class User < ActiveRecord::Base
  ROLES = %w(admin user)

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :role, presence: true, inclusion: {in: ROLES}
  validates :email, presence: true

  has_many :tasks, foreign_key: :owner_id

  ROLES.each do |role|
    define_method "is_#{role}?" do
      self.role == role
    end
  end
end
