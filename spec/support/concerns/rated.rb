require 'spec_helper'

shared_examples_for 'rated' do
  let(:model) { create(described_class.to_s.underscore, :complete) }

  it { should have_many(:ratings).dependent(:destroy) }

  it 'has ratings' do
    expect(model.ratings.build).to be_an_instance_of(Rating)
  end
end
