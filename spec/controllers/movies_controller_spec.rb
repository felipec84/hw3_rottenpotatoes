require 'spec_helper'

describe MoviesController do
  describe 'find movie with same director' do
    it 'should call the model method that performs the search' do
      movie = FactoryGirl.create(:movie, :title => 'Milk')
      Movie.any_instance.should_receive(:find_by_same_director)
      post :same_director, {:id => movie.id}
    end
    context 'we know the director' do
      it 'should select the Director Results template for rendering' do
        movie = FactoryGirl.create(:movie, :title => 'Milk')
        Movie.any_instance.stub(:find_by_same_director)
        post :same_director, {:id => movie.id}
        response.should render_template('same_director') 
      end
      it 'should make the Director Resutls available to that template' do
        fake_results = [mock('Movie'), mock('Movie')]
        movie = FactoryGirl.create(:movie, :title => 'Milk')
        Movie.any_instance.stub(:find_by_same_director).and_return(fake_results)
        post :same_director, {:id => movie.id}
        # look for controller method to assign @movies
        assigns(:movies).should == fake_results
      end
    end
    context 'we don\'t know the director' do
      it 'should select the homepage template for rendering' do
        movie = FactoryGirl.create(:movie, :title => 'Milk', :director => "")
        Movie.any_instance.stub(:find_by_same_director).and_raise(Movie::NoDirectorInfo)
        post :same_director, {:id => movie.id}
        response.should redirect_to('/movies') 
        end
      it 'should set the flash variable' do
        movie = FactoryGirl.create(:movie, :title => 'Milka', :director => "")
        Movie.any_instance.stub(:find_by_same_director).and_raise(Movie::NoDirectorInfo)
        post :same_director, {:id => movie.id}
        flash[:notice].should_not be_nil
        end
    end
  end
end
