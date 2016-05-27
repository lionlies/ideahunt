class Idea < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  belongs_to :owner, class_name: "User", foreign_key: :user_id

  has_many :comments, dependent: :destroy
  has_many :upvoted_users, through: :votes, source: :user

  def editable_by?(user)
    user && user == owner
  end

end
