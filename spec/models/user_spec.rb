require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:answers) }
  it { should have_many(:questions) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe 'method author_of?' do
     let(:user) { create(:user) }
     let(:question) { create(:question, user: user) }
     let(:foreign_question) { create(:question) }

     it "user is the author" do
       expect(user).to be_author_of(question)
     end

     it "user is not the author" do
       expect(user).not_to be_author_of(foreign_question)
     end
   end
end
