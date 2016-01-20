class Restaurant < ActiveRecord::Base

  has_many :reviews, dependent: :destroy
  belongs_to :user

  validates :name, length: {minimum: 3}, uniqueness: true

  def build_review(review_params, current_user)
    @restaurant = self
    Review.create(thoughts: review_params[:thoughts],
                    rating: review_params[:rating],
                    restaurant_id: @restaurant.id,
                    user_id: current_user.id)
  end

end
