class Color < ActiveRecord::Base

  def add_vote
    Color.increment_counter(:vote_count, self.id)
    reload
  end

  def remove_vote
    Color.decrement_counter(:vote_count, self.id)
    reload
  end

end

