module Admin::PostsHelper
  def category_options
    if action_name == "edit"
      placeholder = '<option disabled="">Category</option>'
    else
      placeholder = '<option selected="" disabled="">Category</option>'
    end

    (placeholder +
      options_from_collection_for_select(Category.all, :id, :title)).html_safe
  end

  def cover_image_thumbnail(post)
    if post.image
      image_tag post.image.data.url(:thumb_2x),
                alt: "Cover Image",
                class: "img-responsive cover-thumbnail"
    else
      image_tag "#",
                alt: "Cover Image",
                class: "img-responsive cover-thumbnail",
                style: "display: none;"
    end
  end
end