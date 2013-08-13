require 'spec_helper'

describe MoviesController do
  describe 'find movie with same director' do
    it 'should call the model method that performs the search' do
      Movie.should_receive(:find_by_same_director).with(1)
        post :same_director, {:id => 1}
      end
    it 'should select the Director Results template for rendering'
    it 'should make the Director Resutls available to that template'
  end
end
