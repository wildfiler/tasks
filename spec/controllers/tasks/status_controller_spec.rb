require 'spec_helper'

describe Tasks::StatusController do
  login_user

  let(:user){@current_user}
  let(:project) do
    project = create :project
    project.users << user
    project
  end
  let(:owner){create :user}
  let(:task){create :task, project: project, state: state, owner: owner}
  let(:state){:new}

  context do
    before :each do
      post action, task_id: task.id
      task.reload
    end
    describe 'POST reopen' do
      let(:state){:in_work}
      let(:action){:reopen}
      it 'change task state to new' do
        expect(task.state?(:new)).to be_true
      end
    end
    describe 'POST start' do
      let(:state){:new}
      let(:action){:start}
      it 'change task state to new' do
        expect(task.state?(:in_work)).to be_true
      end
    end
    describe 'POST suspend' do
      let(:state){:new}
      let(:action){:suspend}
      it 'change task state to new' do
        expect(task.state?(:suspended)).to be_true
      end
    end
    describe 'POST finish' do
      let(:state){:new}
      let(:action){:finish}
      it 'change task state to new' do
        expect(task.state?(:finished)).to be_true
      end
    end
  end

  describe "access rights for" do
    describe "POST finish" do
      it 'redirect to project if user is project member' do
        post :finish, task_id: task.id
        expect(response).to redirect_to(project_path(project))
      end

      describe 'if user is not in project' do
        let(:project){create :project}

        it 'redirect to tasks' do
          post :finish, task_id: task.id
          expect(response).to redirect_to(tasks_path)
        end
      end

      describe 'if task not in project' do
        let(:project){nil}

        describe 'and own task' do
          let(:owner){user}

          it 'redirect to tasks' do
            post :finish, task_id: task.id
            expect(response).to redirect_to(tasks_path)
          end
        end

        describe 'and not own task' do
          it 'redirect to tasks' do
            post :finish, task_id: task.id
            expect(response).to redirect_to(tasks_path)
          end
        end
      end
    end
    %w(reopen start suspend).each do |action|
      describe "POST #{action}" do
        it 'redirect to task if user is project member' do
          post action, task_id: task.id
          expect(response).to redirect_to(task_path(task))
        end

        describe 'if user is not in project' do
          let(:project){create :project}

          it 'redirect to tasks' do
            post action, task_id: task.id
            expect(response).to redirect_to(tasks_path)
          end
        end

        describe 'if task not in project' do
          let(:project){nil}

          describe 'and own task' do
            let(:owner){user}

            it 'redirect to task' do
              post action, task_id: task.id
              expect(response).to redirect_to(task_path(task))      
            end
          end

          describe 'and not own task' do
            it 'redirect to tasks' do
              post action, task_id: task.id
              expect(response).to redirect_to(tasks_path)
            end
          end
        end
      end
    end
  end
end