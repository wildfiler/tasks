FactoryGirl.define do
  factory :task do
    title "Task title"
    description ""
    state :new
    owner
  end
end