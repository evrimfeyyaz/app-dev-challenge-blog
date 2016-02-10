atom_feed do |feed|
  feed.title "AppDevChallenge Posts"
  feed.updated @posts.maximum(:published_at)

  @posts.each do |post|
    feed.entry post, published: post.published_at do |entry|
      entry.title post.title
      entry.content(markdown(post.content), type: :html)
      entry.author do |author|
        author.name "Evrim Persembe"
      end
    end
  end
end