require 'spec_helper'

describe TaskListController do
  render_views
  login_user

  describe 'GET all' do
    it 'assigns all available tasks' do
      own_tasks_wo_project = create_list :task, 3, owner: @current_user

      own_project = create :project, owner: @current_user
      tasks_in_own_project = create_list :task, 3, project_id: own_project.id

      project = create :project
      project.users << @current_user
      tasks_in_anothern_project = create_list :task, 3, project_id: project.id

      get :all
      all_tasks = own_tasks_wo_project + tasks_in_own_project + tasks_in_anothern_project
      expect(assigns(:tasks)).to match_array(all_tasks)
    end

    it 'assigns own tasks' do
      tasks = create_list :task, 3, owner: @current_user
      get :all
      expect(assigns(:tasks)).to match_array(tasks)
    end

    it 'assigns tasks from user project' do
      project = create :project, owner: @current_user
      tasks = create_list :task, 3, project_id: project.id
      get :all
      expect(assigns(:tasks)).to match_array(tasks)
    end

    it 'assigns tasks from projects in which user is member' do
      project = create :project
      project.users << @current_user
      tasks = create_list :task, 3, project_id: project.id
      get :all
      expect(assigns(:tasks)).to match_array(tasks)
    end

    it 'not render layout' do
      get :all
      expect(response).to_not render_template('layouts/application')
    end

    it 'render tasks_with_project partial' do
      get :all
      expect(response).to render_template(partial: '_tasks_with_project')
    end
  end

  describe 'GET without_project' do
    it 'assigns all tasks without project' do
      tasks = create :task, owner: @current_user, project_id: nil
      get :without_project
      expect(assigns(:tasks)).to match_array([tasks])
    end

    it 'assigns only my own tasks' do
      tasks = create :task, project_id: nil
      get :without_project
      expect(assigns(:tasks)).to_not match_array([tasks])
    end

    it 'not render layout' do
      get :without_project
      expect(response).to_not render_template('layouts/application')
    end

    it 'render tasks_wo_project partial' do
      get :without_project
      expect(response).to render_template(partial:'_tasks_wo_project')
    end
  end

  describe 'GET project' do
    it 'assigns all tasks from own project' do
      project = create :project, owner: @current_user
      task = create :task, project_id: project.id
      get :project, id: project.id
      expect(assigns(:tasks)).to match_array([task])
    end
    
    it 'assigns all tasks from anothers project' do
      project = create :project
      project.users << @current_user
      task = create :task, project_id: project.id
      get :project, id: project.id
      expect(assigns(:tasks)).to match_array([task])
    end

    it 'not render layout' do
      project = create :project, owner: @current_user
      get :project, id: project.id
      expect(response).to_not render_template('layouts/application')
    end

    it 'renders tasks_wo_project partial' do
      project = create :project, owner: @current_user
      get :project, id: project.id
      expect(response).to render_template(partial: '_tasks_wo_project')
    end
  end
end