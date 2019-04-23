require 'rails_helper'

RSpec.describe Rating, type: :model do
 it { should belong_to :linkable }
 it { should have_many(:votes) }

 it { should validate_numericality_of :score }
end
