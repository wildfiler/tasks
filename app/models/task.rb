class Task < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :owner, class_name: 'User'
  belongs_to :project

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
