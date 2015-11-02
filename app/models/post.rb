class Post < ActiveRecord::Base
  include Votable
  include Sluggable

  belongs_to :creator, foreign_key: "user_id", class_name: "User"
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: { :minimum => 5 }
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  # to specify variable slug attribute in module as name
  sluggable_column :title

# NOTE:  I added all these to a module and/or gem in /lib
# Files under /lib are not by default autoloaded into Rails
# So when adding the module remember to include the loadpath in application.rb

  # def total_votes
  #   self.up_votes - self.down_votes
  # end

  # def up_votes
  #   self.votes.where(:vote => true).size
  # end

  # def down_votes
  #   self.votes.where(:vote => false).size
  # end

# put this into a module
=begin
  def to_param
    self.slug
  end

  def create_slug
    the_slug = to_slug(self.title)
    post = Post.find_by(slug: the_slug)
    count = 2
    while post && post != self
      the_slug = append_suffix(the_slug, count)
      post = Post.find_by slug: the_slug
      count += 1
    end
    self.slug = the_slug.downcase
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + '-' + count.to_s
    else
      return str + "-" + count.to_s
    end
  end

  def to_slug(name)
    str = name.strip
    # str.gsub!(/\W/, '-')
    str.gsub!(/\s*[^A-Za-z0-9]\s*/,'-')
    str.gsub!(/-+/,'-')
    str.downcase
  end
=end

end
