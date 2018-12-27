class CreateWorkDiaryMoods < ActiveRecord::Migration
  def change
    create_table :work_diary_moods do |t|
    	t.integer	:work_diary_id
    	t.integer :user_id
    	t.integer :mood

      t.timestamps null: false
    end
  end
end
