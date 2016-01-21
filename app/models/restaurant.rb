class Restaurant < ActiveRecord::Base

  has_many :reviews, dependent: :destroy
  belongs_to :user

  validates :name, length: {minimum: 3}, uniqueness: true

  def build_review(review_params, current_user)
    review = reviews.build({thoughts: review_params[:thoughts],
                    rating: review_params[:rating],
                    restaurant: self,
                    user: current_user})
  end
end
