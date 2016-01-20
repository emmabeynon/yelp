require 'spec_helper'

describe User, type: :model do
  it { should have_many(:restaurants) }
  it { should have_many(:reviews) }
  it { is_expected.to have_many :reviewed_restaurants }
end
