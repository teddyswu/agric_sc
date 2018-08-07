class FbToAw < ActiveRecord::Base
	mount_uploader :file, FbToAwsUploader
	validates :file, presence: true

	def update_urls_success?
    begin
      puts "file is #{self.file.present?}"
      # 這邊就寫, 如果 file 存在, 就 update url 要不然就不要 update
      if self.file.present?
        s3_host = "https://sogi-channel.s3.amazonaws.com"
        update_datas = {
          :origin_url => self.file.url,        # 轉原圖
          :cover_url => self.file.thumb.url,
          :show_url => self.file.show.url
        }
        if self.update_attributes( update_datas )
          return true
        else
          return false
        end
      end
    rescue Exception => e
      logger.error("Uploader Error!! cannot update url")
      logger.error("==================================")
      logger.error(e)
      logger.error("==================================")
      return false
    end
  end
end
