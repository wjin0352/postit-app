class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: "user_id", class_name: "User"
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :votable

  validates :title, presence: true, length: { :minimum => 5 }
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  before_save :create_slug

  def total_votes
    self.up_votes - self.down_votes
  end

  def up_votes
    self.votes.where(:vote => true).size
  end

  def down_votes
    self.votes.where(:vote => false).size
  end

  def create_slug
    self.slug = self.title.gsub(' ','-').downcase
  end

  def to_param
    # to_param() public
    # Returns a String, which Action Pack uses for constructing an URL to this object. The default implementation returns this record’s id as a String, or nil if this record’s unsaved.
    # You can override to_param in your model to make user_path construct a path using the user’s name instead of the user’s id:

    self.slug
  end

end
