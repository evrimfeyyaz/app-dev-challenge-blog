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
end