class Comment < ActiveRecord::Base
  belongs_to :idea
  belongs_to :author, class_name: "User", foreign_key: :user_id

end
