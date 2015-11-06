class Post < ActiveRecord::Base
  include Votable
  include Sluggable

  PER_PAGE = 3

  belongs_to :creator, foreign_key: "user_id", class_name: "User"
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: { :minimum => 5 }
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  # to specify variable slug attribute in module as name
  sluggable_column :title


# NOTE:  I added all vote methods to a module and/or gem in /lib
# Files under /lib are not by default autoloaded into Rails
# So when adding the module remember to include the loadpath in application.rb

end
