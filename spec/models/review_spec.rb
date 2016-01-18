require 'spec_helper'

describe Review do
  it { should belong_to(:restaurant) }

  it { should belong_to(:restaurant).dependent(true) }
end
