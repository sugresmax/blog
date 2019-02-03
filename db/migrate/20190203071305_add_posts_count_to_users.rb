class AddPostsCountToUsers < ActiveRecord::Migration[5.2]

  def up
    add_column :users, :posts_count, :integer

    User.reset_column_information
    User.find_each do |user|
      User.reset_counters user.id, :posts
    end
  end

  def down
    remove_column :users, :posts_count
  end

end
