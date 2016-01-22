class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :name, length: {minimum: 3}, uniqueness: true

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def build_review(review_params, current_user)
    review = reviews.build({thoughts: review_params[:thoughts],
                    rating: review_params[:rating],
                    restaurant: self,
                    user: current_user})
  end

  def average_rating
    return 'N/A' if reviews.none?
    # alternative = reviews.inject(0) {|memo, review| memo + review.rating} / reviews.size
    reviews.average(:rating)
  end
end
