class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :task_id
	  t.datetime :deleted_at

      t.timestamps
    end
    add_index :comments, [:task_id, :created_at]
    add_index :comments, :deleted_at 
  end
end
