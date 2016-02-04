class Post < ActiveRecord::Base
  belongs_to :category, counter_cache: true
  belongs_to :image

  scope :published, -> { where.not(published_at: nil) }

  def previous_post
    Post.where("id < ?", id).order("id DESC").first
  end

  def next_post
    Post.where("id > ?", id).order("id ASC").first
  end
end
