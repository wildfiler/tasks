class CreateProjectsUsers < ActiveRecord::Migration
  def change
    create_table :projects_users, :id => false do |t|
      t.integer :project_id
      t.integer :user_id
      t.index [:project_id, :user_id], unique: true
    end
  end
end
