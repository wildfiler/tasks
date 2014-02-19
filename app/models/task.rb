class Task < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  belongs_to :project

  validates :title, presence: true
  validates :owner, presence: true

  # states: new, in_work, suspended, finished
  state_machine :state, initial: :open do
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
  end

  def is_owner?(user)
    self.owner_id == user.id
  end

  # def state_
  #   I18n.t("task.state.#{super}")
  # end
end
