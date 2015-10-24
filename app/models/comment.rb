class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :votes, as: :votable

  validates :body, presence: true


  def comment_total_votes
    self.comment_up_votes - self.comment_down_votes
  end

  def comment_up_votes
    self.votes.where(:vote => true).size
  end

  def comment_down_votes
    self.votes.where(:vote => false).size
  end

end
