require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }
  it { should belong_to (:user) }

  describe 'creating a restaurant' do
    it 'is not valid with a name of less than 3 characters' do
      restaurant = Restaurant.new(name: 'kf')
      expect(restaurant).to have(1).error_on(:name)
      expect(restaurant).not_to be_valid
    end

    it 'is not valid unless it has a unique name' do
      Restaurant.create(name: 'Moe\'s Tavern')
      restaurant = Restaurant.new(name: 'Moe\'s Tavern')
      expect(restaurant).to have(1).error_on(:name)
    end

    xit 'require a user id' do
      expect(restaurant.user_id).not_to be_nil
    end
  end

  describe '#build_review' do
    let(:user) {User.create(email: 'jane@doe.com')}
    let(:restaurant) {Restaurant.create(name: 'KFC')}
    let(:review_params) {{rating: 1, thoughts: 'whatever'}}
    it 'returns a review' do
      review = restaurant.build_review(review_params, user)
      expect(review).to be_a Review
    end

    it 'creates a review associated with the correct user' do
      review = restaurant.build_review(review_params, user)
      expect(review.user).to eq user
    end
  end
end
