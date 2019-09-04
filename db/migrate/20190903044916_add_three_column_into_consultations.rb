class AddThreeColumnIntoConsultations < ActiveRecord::Migration
  def change
  	add_column :consultations, :enabled, :boolean, :after => :json
  	add_column :consultations, :title, :string, :after => :json
  	add_column :consultations, :pic, :text, :after => :title
  	add_column :consultations, :intro, :text, :after => :pic
  	add_column :consultations, :button_name, :string, :after => :intro
  end
end
