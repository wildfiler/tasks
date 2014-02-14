class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.references :owner, index: true
      t.text :description

      t.timestamps
    end
  end
end
