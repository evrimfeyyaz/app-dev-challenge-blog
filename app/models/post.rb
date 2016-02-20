class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :category, counter_cache: true
  belongs_to :image

  validates :title, presence: true
  validates :content, presence: true

  scope :published, -> {
    where.not(published_at: nil).order(:published_at, :desc)
  }

  def previous_post
    Post.where("id < ?", id).order("id DESC").first
  end

  def next_post
    Post.where("id > ?", id).order("id ASC").first
  end

  def published?
    self.published_at
  end
end
