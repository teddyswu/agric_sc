class RecordPdf < Prawn::Document
	def initialize(before_records,after_records)
		super(top_margin: 40)
		font "/Library/Fonts/Kaiu.ttf"
		@before_records = before_records
		@before_work_projects = ""
		WorkProject.where(:record_type => 1).each do |bwp|
      @before_work_projects << bwp.name
      @before_work_projects << "\n"
    end
		@after_records = after_records
    font("/Library/Fonts/Kaiu.ttf", :size => 14) do
		  text "農場工作紀錄"
    end
	  before_line_items
	  start_new_page
    font("/Library/Fonts/Kaiu.ttf", :size => 14) do
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
  	[[{:content => "工作日期", :align => :center}, {:content => "田區代號", :align => :center}, {:content => "作物別", :align => :center},	{:content => "工作項目", :align => :center},	"備註"]]+
  	@before_records.each_with_index.map do |item, i |
  		if i == 0
  			[{:content => item.work_time.try(:strftime, '%Y-%m-%d' ), :width => 80, :align => :center}, {:content => item.filed_code, :width => 60, :align => :center}, {:content => item.farming_category, :width =>60, :align => :center}, {:content => item.work_project, :width => 210, :align => :center}, {:content => "各工作項目如下：
                                                                                                                                                      #{@before_work_projects}", :rowspan => @before_records.size} ]
  	  else
  	   	[{:content => item.work_time.try(:strftime, '%Y-%m-%d' ), :align => :center}, {:content => item.filed_code, :align => :center}, {:content => item.farming_category, :align => :center}, {:content => item.work_project, :align => :center} ]
  		end
  	end
  end

  def after_line_rows
  	[[{:content => "日期", :align => :center}, {:content => "田區代號", :align => :center}, {:content => "作物別", :align => :center}, {:content => "採收批號", :align => :center}, {:content => "採收量(  臺斤  )", :align => :center}, {:content => "採收後作業內容", :align => :center}, {:content => "倉儲代號", :align => :center}]]+
    @after_records.each_with_index.map do |item, i |
     	[{:content => item.work_time.try(:strftime, '%Y-%m-%d' ), :align => :center}, {:content => item.filed_code, :align => :center}, {:content => item.farming_category, :align => :center}, {:content => "",:width => 80}, {:content => item.weight.to_s, :align => :center}, {:content => item.work_project, :align => :center}, {:content => "",:width => 80}]
    end
  end

end