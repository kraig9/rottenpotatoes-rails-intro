class Movie < ActiveRecord::Base
    @maturity=['G','PG','PG-13','R']
  def self.maturity
    @maturity
  end
  def self.maturity=(new_maturity)
    @maturity = new_maturity
  end
end
