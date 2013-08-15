class Movie < ActiveRecord::Base
  ## Exception Handling
  class NoDirectorInfo < StandardError
  end
  
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def find_by_same_director
    if (self.director.nil? || self.director.empty?) 
      raise NoDirectorInfo
    end
    Movie.find_all_by_director(self.director)
  end
end
