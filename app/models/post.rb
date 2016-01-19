class Post < ActiveRecord::Base
  belongs_to :category

  # TODO: Implement paperclip.
  def image
    "test.jpg"
  end
end