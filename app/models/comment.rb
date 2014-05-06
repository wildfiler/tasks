class Comment < ActiveRecord::Base
	acts_as_paranoid

	belongs_to :task
	belongs_to :user

	default_scope -> { order('created_at ASC') }

	validates :user_id, presence: true
	validates :task_id, presence: true
	validates :content, presence: true

	def author_name
	    self.user.name;
	end
end
