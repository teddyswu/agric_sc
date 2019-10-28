class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
    	t.text	:def_season
    	t.text	:def_week

      t.timestamps null: false
    end
  end
end
