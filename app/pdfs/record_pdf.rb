class RecordPdf < Prawn::Document
	def initialize(records,work_projects,record_type)
		super(top_margin: 70)
		font"/Library/Fonts/Arial Unicode.ttf"
		@records = records
		@work_projects = work_projects
		@record_type = record_type
		record_title
	  line_items
	end

	def record_title
		text @record_type=="1" ? "農場工作紀錄" : "採收及採收後處理紀錄"
		
	end
	
	def line_items
		table (line_item_rows) do 
		end
			
	end

  def line_item_rows
  	[["工作時間",	"作物種類",	"田區代號",	"紀錄事項",	"備註"]]+
  	@records.each_with_index.map do |item, i |
  		if i == 0
  			[item.created_at.strftime( '%Y-%m-%d' ), item.farming_category, item.filed_code, item.work_project, {:content => "各工作項目如下：#{@work_projects.gsub('<br >', '、').chop}", :rowspan => @records.size, :width => 250} ]
  	  else
  	  	[item.created_at.strftime( '%Y-%m-%d' ), item.farming_category, item.filed_code, item.work_project ]
  		end
  	end
  end

end