class Movie < ActiveRecord::Base
  def self.maturity
    @maturity=['G','PG','PG-13','R']
  end
end
