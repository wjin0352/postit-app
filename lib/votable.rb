# using conserns, allows us to write much cleaner syntax

module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def total_votes
    self.up_votes - self.down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

end

# using normal meta-programming
=begin
module Voting
  # just include this module for voting functionality

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do
      my_class_method
    end
  end

  module InstanceMethods
    def total_votes
      self.up_votes - self.down_votes
    end

    def up_votes
      self.votes.where(:vote => true).size
    end

    def down_votes
      self.votes.where(:vote => false).size
    end
  end

  module ClassMethods
    def my_class_method
      has_many :votes, as: :votable
    end
  end

end
=end
