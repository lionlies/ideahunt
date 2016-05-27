class Vote < ActiveRecord::Base
  belongs_to :idea, counter_cache: true
  belongs_to :user
  validates_uniqueness_of :idea_id, scope: :user_id
end
