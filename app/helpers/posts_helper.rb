module PostsHelper
  def markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(text).html_safe
  end

  def published_at(post)
    if post.published_at
      post.published_at
    else
      "Not Published"
    end
  end
end