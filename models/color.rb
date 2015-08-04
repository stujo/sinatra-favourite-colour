require 'paleta'

class Color < ActiveRecord::Base

  attr_accessor :selected

  def add_vote
    Color.increment_counter(:vote_count, self.id)
    reload
  end

  def remove_vote
    Color.decrement_counter(:vote_count, self.id)
    reload
  end

  def inverse_color
    Paleta::Color.new(:hex, hex_code).invert!.darken(20).hex
  end

end

