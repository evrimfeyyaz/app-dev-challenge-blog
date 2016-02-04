class AddPostsCountToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :posts_count, :integer, null:false, default: 0

    ids = Set.new
    Post.all.each {|c| ids << c.category_id}
    ids.each do |category_id|
      Category.reset_counters(category_id, :posts)
    end
  end

  def self.down
    remove_column :categories, :posts_count
  end
end
