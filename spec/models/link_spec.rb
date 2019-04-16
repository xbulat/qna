require 'rails_helper'

RSpec.describe Link, type: :model do
 it { should belong_to :linkable }

 it { should validate_presence_of :name }
 it { should validate_presence_of :url }

 describe 'gist methods' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }

    let(:link) { create(:link, linkable: question) }
    let(:gist_link) { create(:link, :gist, linkable: question) }

    it 'check type of links' do
      expect(link.gist?).to be false
      expect(gist_link.gist?).to be true
    end

    it 'get gist_id from gist link' do
      expect(gist_link.gist_id).to eq '83ce41c77955f86eeee9c475783388da'
    end
    
    it 'get gist_content' do
      expect(gist_link.gist_content.first.to_s).to eq('Test1')
    end
  end
end
