class AddCommentsCountToUsers < ActiveRecord::Migration[5.2]

  def up
    add_column :users, :comments_count, :integer

    User.reset_column_information
    User.find_each do |user|
      User.reset_counters user.id, :comments
    end
  end

  def down
    remove_column :users, :comments_count
  end

end
