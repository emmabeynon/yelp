require 'rails_helper'

describe RestaurantsController do
  it { should use_before_action(:authenticate_user!) }
end
