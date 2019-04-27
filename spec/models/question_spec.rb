require 'rails_helper'

RSpec.describe Question, type: :model do
  it_behaves_like 'rated'
  it_behaves_like 'linkable'

  it { should have_many(:answers).dependent(:destroy) }
  it { should have_one(:badge) }
  it { should belong_to :user }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
end
