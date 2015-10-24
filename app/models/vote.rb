class Vote < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :votable, polymorphic: true
  validates_uniqueness_of :creator, scope: [:votable_id, :votable_type], message: "You can only vote once."

end
