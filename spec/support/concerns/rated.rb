require 'spec_helper'

shared_examples_for 'rated' do
  let(:model) { create(described_class.to_s.underscore, :complete) }

  it { should have_one(:rating).dependent(:destroy) }

  it 'has rating' do
    expect(model.rating).to be_an_instance_of(Rating)
  end
end
