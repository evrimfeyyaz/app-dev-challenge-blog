# Based on http://stackoverflow.com/a/2077677
# and http://stackoverflow.com/a/19238952

class SitemapController < ApplicationController
  layout nil

  def index
    headers['Content-Type'] = 'application/xml'
    last_post = Post.last

    if stale?(:etag => last_post, :last_modified => last_post.updated_at.utc)
      respond_to do |format|
        format.xml { @posts = Post.all }
      end
    end
  end
end