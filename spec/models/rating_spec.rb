require 'rails_helper'

RSpec.describe Rating, type: :model do
  it { should belong_to :linkable }
  it { should belong_to :user }

  it do
    should validate_inclusion_of(:score).
      in_array([-1, 1])
  end
end
