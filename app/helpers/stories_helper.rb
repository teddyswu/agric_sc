module StoriesHelper
	def jquery_fileupload_for_original
    options = {
      option: {
        resource_type: "Article",
        resource_id: nil
      }
    }

    render 'upload_tools/jquery_fileupload_original', options.merge!(table_params: { })
  end
end
