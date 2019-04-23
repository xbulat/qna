require 'rails_helper'

RSpec.describe Answer, type: :model do
  it_behaves_like 'rated'
  it_behaves_like 'linkable'

  it { should belong_to :question }
  it { should belong_to :user }

  it { should have_one(:badge) }

  it { should validate_presence_of :body }


  describe 'method make_best' do
     let(:question) { create(:question) }
     let(:answer) { create(:answer, question: question) }
     let(:answer2) { create(:answer, question: question) }
     let!(:old_best_answer) { create(:answer, question: question, best: true) }

     let(:another_question_answer) { create(:answer, :with_question) }

     before { answer.make_best }

     it 'set new best answer' do
       expect(answer.reload.best).to be_truthy
     end

     it 'previos the best answer is not best' do
       expect(old_best_answer.reload.best).to be_falsey
     end

     it 'question has only one the best answer' do
       answer2.make_best

       expect(question.answers.where(best: true).count).to eq(1)
     end

     it 'each question is able to has the best answer' do
       another_question_answer.make_best

       expect(answer.best).to be_truthy
       expect(another_question_answer.best).to be_truthy
     end
   end
end
