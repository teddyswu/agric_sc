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

  def render_story_tag(story_tags)
  	tag = ""
  	story_tags.each do |st|
      tag << st.name
      tag << "、"
    end
    tag.chop
  end
end
