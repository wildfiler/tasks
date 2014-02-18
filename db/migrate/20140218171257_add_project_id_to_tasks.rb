class AddProjectIdToTasks < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.belongs_to :project
    end
  end
end
