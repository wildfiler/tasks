require 'spec_helper'
require 'pp'

describe TasksController do
  login_user
  describe 'GET show' do
    let(:task) {create :task, owner: @current_user}
    describe 'for own task' do
      before :each do
        get :show, {id: task.id}
      end
      it 'assigns the requested task' do
        expect(assigns(:task)).to eq(task)
      end
      it 'responds with 200' do
        expect(response.status).to eq(200)
      end
    end
    describe 'for another user task' do
      let(:project) { create :project}
      let(:task) {create :task, project_id: project.id}
      describe 'of the project which I am' do
        it 'assigns the requested task' do
          get :show, {id: task.id}
          expect(assigns(:task)).to eq(task)
        end

        it 'responds with 200' do
          project.users << @current_user
          get :show, {id: task.id}
          expect(response.status).to eq(200)
        end
      end
      it 'redirect to tasks' do
          get :show, {id: task.id}
          expect(response).to redirect_to tasks_path
      end
    end
  end

  describe 'GET new' do
    before :each do
      get :new
    end
    it 'assigns new to task state' do
      expect(assigns(:task).state?(:new)).to be_true
    end
    it 'responds with 200' do
      expect(response.status).to eq(200)
    end
    it 'assigns a new task as @task' do
      expect(assigns(:task)).to  be_a_new(Task)
    end
  end
end