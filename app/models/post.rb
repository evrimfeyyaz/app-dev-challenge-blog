class Post < ActiveRecord::Base
  belongs_to :category

  def previous_post
    Post.where("id < ?", id).order("id DESC").first
  end

  def next_post
    Post.where("id > ?", id).order("id ASC").first
  end

  # TODO: Implement paperclip.
  def image
    "test.jpg"
  end
end