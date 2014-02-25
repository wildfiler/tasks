require 'spec_helper'

describe Project do
  it 'creating from factory should include owner in users' do
    project = create :project
    expect(project.users).to include(project.owner)
  end
end
