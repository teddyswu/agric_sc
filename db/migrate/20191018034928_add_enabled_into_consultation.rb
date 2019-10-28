class AddEnabledIntoConsultation < ActiveRecord::Migration
  def change
  	add_column :consultation_options, :enabled, :boolean, :after => :sort
  	add_column :consultation_contents, :enabled, :boolean, :after => :content
  	add_column :consultation_cates, :enabled, :boolean, :after => :sort
  end
end
