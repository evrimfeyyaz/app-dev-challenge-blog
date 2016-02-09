module PostsHelper
  require_dependency './lib/redcarpet/render_post_excerpt.rb'

  def markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(text).html_safe
  end

  def strip_markdown(text)
    Redcarpet::Markdown.new(PostExcerpt).render(text).html_safe
  end

  def published_at(post)
    if post.published_at
      format_time(post.published_at)
    else
      "Not Published"
    end
  end

  def link_to_post_category(post)
    if post.category
      link_to post.category.title, post.category
    else
      # TODO: Add link to "uncategorized"
      "Uncategorized"
    end
  end
end