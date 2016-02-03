class AddImageToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :image, index: true, foreign_key: true
  end
end
