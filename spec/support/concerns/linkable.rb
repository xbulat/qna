require 'spec_helper'

shared_examples_for 'linkable' do
  let (:model) { create(described_class.to_s.underscore, :complete) }

  it { should have_many(:links).dependent(:destroy) }

  it { should accept_nested_attributes_for :links }

  it 'have many attached files' do
    expect(model.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end
end
