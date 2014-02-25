FactoryGirl.define do
  factory :project do
    title 'Test Project'
    owner
    after :create do |project|
      project.users << project.owner
    end
  end
end