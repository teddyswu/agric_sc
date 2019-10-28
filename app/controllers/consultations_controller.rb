class ConsultationsController < ApplicationController
	before_action :is_admin, only: [:index]
	require "csv"

	def index
		@cons = Consultation.all.paginate(:page => params[:page], per_page: 10)
	end

	def edit
		@con = Consultation.find(params[:id])
	end

	def new
		@con = Consultation.new
	end

	def card_edit
		@con = Consultation.find(params[:id])
	end

	def card_update
		@con = Consultation.find(params[:id])
		@con.update(consultation_params)

		redirect_to :action => :index
	end

	def data_create
		aa = params[:consultation][:file]
		CSV.foreach(aa.path, headers: true) do |row|
			cate = ConsultationCate.find_or_create_by(:consultation_id => row[0], :name => row[1])
			if cate.new_record?
				cate.intro = row[2]
				cate.pic = row[3]
				cate.sort = row[4]
				cate.enabled = true
				cate.save!
			end
			option = ConsultationOption.find_or_create_by(:consultation_cate_id => cate.id, :name => row[5])
			if option.new_record?
				option.sort = row[6]
				option.enabled = true
				option.save!
			end
			content = ConsultationContent.find_or_create_by(:consultation_option_id => option.id, :gender => row[7], :age_range => row[8])
			if content.new_record?
				content.intro = row[9]
				content.pic = row[10]
				content.content = row[11]
				content.save!
			end
		end

		redirect_to :action => :index
	end

	def data_list
		@data_list = ConsultationCate.where(:consultation_id => params[:id]).paginate(:page => params[:page], per_page: 10)
	end

	def data_edit
		@data = ConsultationCate.find(params[:id])
	end

  def data_update
  	@data = ConsultationCate.find(params[:id])
  	@data.update(cate_params)

  	redirect_to data_list_consultation_path(@data.consultation_id)
  end

  def data_destory
  	cc = ConsultationCate.find(params[:id])
  	cc.enabled = (cc.enabled == true ? false : true)
    cc.save!
  	redirect_to data_list_consultation_path(cc.consultation_id)
  end

  def option_list
  	@option_list = ConsultationOption.where(:consultation_cate_id => params[:id]).paginate(:page => params[:page], per_page: 10)
	end

	def option_edit
		@option = ConsultationOption.find(params[:id])
	end

	def option_update
		@option = ConsultationOption.find(params[:id])
		@option.update(option_params)

		redirect_to option_list_consultation_path(@option.consultation_cate_id)
	end

	def option_destory
  	cc = ConsultationOption.find(params[:id])
  	cc.enabled = (cc.enabled == true ? false : true)
    cc.save!
  	redirect_to option_list_consultation_path(cc.consultation_cate_id)
  end

	def cont_list
		@cont_list = ConsultationContent.where(:consultation_option_id => params[:id]).paginate(:page => params[:page], per_page: 10)
	end

	def cont_edit
		@cont = ConsultationContent.find(params[:id])
	end

	def cont_update
		@cont = ConsultationContent.find(params[:id])
		@cont.update(consultation_content_params)

		redirect_to cont_list_consultation_path(@cont.consultation_option_id)
	end

	def cont_destory
  	cc = ConsultationContent.find(params[:id])
  	cc.enabled = (cc.enabled == true ? false : true)
    cc.save!
  	redirect_to cont_list_consultation_path(cc.consultation_option_id)
  end

	def into_data
		@con = Consultation.new
	end

	def destroy
  	mp = Consultation.find(params[:id])
  	mp.enabled = (mp.enabled == true ? false : true)
    mp.save!
  	redirect_to :action => :index
  end

  def create
  	@con = Consultation.new(consultation_params)
  	@con.enabled = true
		@con.save

		redirect_to :action => :index
  end

  def update
  	@con = Consultation.find(params[:id])
		@con.update(consultation_params)

		redirect_to :action => :index
  end

  private

  def consultation_params
  	params.require(:consultation).permit(:title, :pic, :intro, :button_name, :name, :parameter_name, :cat, :json)
  end

  def cate_params
  	params.require(:consultation_cate).permit(:name, :intro, :pic, :sort)
  end

  def option_params
  	params.require(:consultation_option).permit(:name, :sort)
  end

  def consultation_content_params
  	params.require(:consultation_content).permit(:intro, :gender, :age_range, :pic, :content)
  end
end
