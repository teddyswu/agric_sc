namespace :data_conversion do
	namespace :conversion do
		task :work_image => :environment do
			work_images = WorkRecordImage.where(:cover_url => nil, :enabled => true)
			work_images.each do |work_image|
				fb_to_aw = Hash.new
        fb_to_aw["remote_file_url"] = work_image.url
				aa = FbToAw.new(fb_to_aw)
		    aa.save!
		    aa.update_urls_success?
		    work_image.cover_url = aa.cover_url
		    work_image.origin_url = aa.origin_url
		    work_image.show_url = aa.file.show.url
		    work_image.save!
		    p work_image.id
			end
		end
		task :work_diary => :environment do
			work_records = WorkRecord.where.not(:filed_code => "X")
			work_records.each do |wr|
				p "wr:#{wr.id}"
				if wr.work_record_images.present?
					comment = wr.work_time.strftime('%Y-%m-%d' ) + "進行" + wr.work_project
					aa = WorkDiary.create(:owner_id => wr.owner_id, :comment => comment, :diary_time => wr.work_time)
					wr.work_record_images.each do |wri|
						p "wri:#{wri.id}"
						aa.work_diary_images.create(:url => wri.url, :cover_url => wri.cover_url, :origin_url => wri.origin_url, :show_url => wri.show_url, :enabled => wri.enabled)
					end
				end
			end
		end
		task :diary_image => :environment do
			work_images = WorkDiaryImage.where(:cover_url => "", :enabled => true)
			work_images.each do |work_image|
				fb_to_aw = Hash.new
        fb_to_aw["remote_file_url"] = work_image.url
				aa = FbToAw.new(fb_to_aw)
		    aa.save!
		    aa.update_urls_success?
		    work_image.cover_url = aa.cover_url
		    work_image.origin_url = aa.origin_url
		    work_image.show_url = aa.file.show.url
		    work_image.save!
		    p work_image.id
			end
		end
	end
end