class StoryImage < ActiveRecord::Base
	mount_uploader :file, StoryUploader

	belongs_to :imageable, :polymorphic => true, :touch => true
  belongs_to :story

	def update_urls_success?
    begin
      puts "file is #{self.file.present?}"
      # 這邊就寫, 如果 file 存在, 就 update url 要不然就不要 update
      if self.file.present?
        # s3_host = "https://sogi-channel.s3.amazonaws.com"
        update_datas = {
          :url_headline => self.file.headline.url,
          :url_cover   => self.file.cover.url,     # 轉大圖
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
