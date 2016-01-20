require 'spec_helper'

describe User, type: :model do
  it { should have_many(:restaurants) }
  it { should have_many(:reviews) }
  it { is_expected.to have_many :reviewed_restaurants }

  xit 'should test whether a user has already reviewed a restaurant' do
    user = User.create (email: 'jane@doe.com', password: 'janedoee', password_confirmation: 'janedoee')
    restaurant = Restaurant.create(name: 'Bobs')
  end
end
