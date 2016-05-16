class AddUserIdToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :user_id, :string
  end
end
