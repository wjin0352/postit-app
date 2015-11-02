class Comment < ActiveRecord::Base
  include Voting
  belongs_to :post
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  validates :body, presence: true



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
end
