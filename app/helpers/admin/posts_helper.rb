module Admin::PostsHelper
  def category_options(post)
    uncategorized = '<option>Uncategorized</option>'

    (uncategorized +
      options_from_collection_for_select(Category.all, :id, :title, post.category_id)).html_safe
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

  def category(post)
    post.category ? post.category.title : "Uncategorized"
  end
end