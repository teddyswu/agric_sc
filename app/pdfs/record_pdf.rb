class RecordPdf < Prawn::Document
	def initialize(before_records,after_records)
		super(top_margin: 70)
		font "/Library/Fonts/Arial Unicode.ttf"
		@before_records = before_records
		@before_work_projects = ""
		WorkProject.where(:record_type => 1).each do |bwp|
      @before_work_projects << bwp.name
      @before_work_projects << "\n"
    end
		@after_records = after_records
    font("/Library/Fonts/Kaiu.ttf", :size => 14, :style => :bold) do
		  text "農場工作紀錄"
    end
	  before_line_items
	  start_new_page
    font("/Library/Fonts/Kaiu.ttf", :size => 14, :style => :bold) do
	    text "採收及採收後處理紀錄" 
	  end
    after_line_items
	end

	def before_line_items
		table (before_line_rows)
	end


  def after_line_items
		table (after_line_rows)
	end

  def before_line_rows
  	[["工作日期", "田區代號", "作物別",	"工作項目",	"備註"]]+
  	@before_records.each_with_index.map do |item, i |
  		if i == 0
  			[{:content => item.created_at.strftime( '%Y-%m-%d' ), :width => 80}, {:content => item.filed_code, :width => 60}, {:content => item.farming_category, :width =>60}, {:content => item.work_project, :width => 210}, {:content => "各工作項目如下：
                                                                                                                                                      #{@before_work_projects}", :rowspan => @before_records.size} ]
  	  else
  	   	[item.created_at.strftime( '%Y-%m-%d' ), item.filed_code, item.farming_category, item.work_project ]
  		end
  	end
  end

  def after_line_rows
  	[["日期", "田區代號", "作物別", "採收批號", "採收量(                )", "採收後作業內容", "倉儲代號"]]+
    @after_records.each_with_index.map do |item, i |
     	[item.created_at.strftime( '%Y-%m-%d' ), item.filed_code, item.farming_category, {:content => "",:width => 80}, "", item.work_project, {:content => "",:width => 80}]
    end
  end

end