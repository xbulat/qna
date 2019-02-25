require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should belong_to :user }

  it { should validate_presence_of :body }

  describe 'method ensure_one_best_answer' do
     let(:question) { create(:question) }
     let!(:old_best_answer) { create(:answer, question: question, best: true) }
     let!(:new_best_answer) { create(:answer, question: question) }

     it 'set new best answer' do
       new_best_answer.make_best

       expect(new_best_answer.reload.best).to be_truthy
       expect(old_best_answer.reload.best).to be_falsey
       expect(question.answers.where(best: true).count).to eq(1)
     end
   end
end
