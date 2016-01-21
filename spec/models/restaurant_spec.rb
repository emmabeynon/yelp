require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }
  it { should belong_to (:user) }
  it { should have_many(:reviews).dependent(:destroy) }

  describe 'creating a restaurant' do
    let(:restaurant) { build :restaurant, :too_short }
    let(:restaurant_created) { create :restaurant, :first}
    let(:restaurant_attempt) { build :restaurant, :first}
    it 'is not valid with a name of less than 3 characters' do
      expect(restaurant).to have(1).error_on(:name)
      expect(restaurant).not_to be_valid
    end

    it 'is not valid unless it has a unique name' do
      restaurant_created
      restaurant_attempt
      expect(restaurant_attempt).to have(1).error_on(:name)
    end
  end

  describe '#build_review' do
    let(:user) {User.create(email: 'jane@doe.com')}
    let(:restaurant) { create :restaurant, :first }
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

  describe '#average_rating' do
    let(:restaurant) { create :restaurant, :first }
    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end

    context '1 review' do
      it 'returns that rating' do
        restaurant.reviews.create(rating: 4)
        expect(restaurant.average_rating).to eq 4
      end
    end

    context 'multiple reviews' do
      it 'returns the average' do
        restaurant.reviews.create(rating: 1)
        restaurant.reviews.create(rating: 5)
        expect(restaurant.average_rating).to eq 3
      end
    end
  end
end
