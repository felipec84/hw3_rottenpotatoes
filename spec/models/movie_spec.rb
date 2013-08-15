require 'spec_helper'

describe Movie do
  describe 'search movies with same director' do
    context 'we know the director' do
      it 'should search with ActiveRecord' do
        movie1 = FactoryGirl.create(:movie, :title => 'Milk', :director => 'dir1')
        movie2 = FactoryGirl.create(:movie, :title => 'Milk1.1', :director => 'dir1')
        movie3 = FactoryGirl.create(:movie, :title => 'Milk2', :director => 'dir2')
        dir1=[movie1, movie2]
        dir2=[movie3]
        movie1.find_by_same_director().should == dir1
        movie3.find_by_same_director().should == dir2
      end
    end
    context 'we don\'t know the director' do
      it 'should raise NoDirectorInfo' do
        movie = FactoryGirl.create(:movie, :title => 'Milk', :director => nil)
        lambda { movie.find_by_same_director() }.
          should raise_error(Movie::NoDirectorInfo)
      end
    end
  end
end
