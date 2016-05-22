class Idea < ActiveRecord::Base
  has_many :votes, dependent: :destroy
  belongs_to :owner, class_name: "User", foreign_key: :user_id

  def editable_by?(user)
    user && user == owner
  end

end
