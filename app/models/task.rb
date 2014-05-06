class Task < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :owner, class_name: 'User'
  belongs_to :project

  has_many :comments, dependent: :destroy

  default_scope {order(created_at: :desc)}

  scope :all_for_user, ->(user) {
    project_ids = user.projects.pluck(:id)
    tasks = Task.includes(:project)
    tasks = tasks.where{((project_id == nil) & (owner_id == my{user.id}) ) | (project_id.in(project_ids))}
    return tasks
  }

  scope :without_project, -> {where(project_id: nil)}

  validates :title, presence: true
  validates :owner, presence: true

  # states: new, in_work, suspended, finished
  state_machine :state, initial: :new do
    event :start do
      transition to:  :in_work
    end

    event :suspend do
      transition to: :suspended
    end

    event :reopen do
      transition to: :new
    end

    event :finish do
      transition to: :finished
    end

    before_transition on: :finish do |task, transition|
      task.finished_at = Time.now
    end
  end

  def is_owner?(user)
    self.owner_id == user.id
  end

  def when_finished
    I18n.l finished_at, format: :short if state?(:finished) && finished_at
  end

  def when_created
    I18n.l created_at, format: :short
  end
end
