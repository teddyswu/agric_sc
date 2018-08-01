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
	end
end