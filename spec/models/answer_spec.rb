require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should belong_to :user }

  it { should validate_presence_of :body }

  describe 'method make_best' do
     let(:question) { create(:question) }
     let(:answer) { create(:answer, question: question) }
     let(:answer2) { create(:answer, question: question) }
     let!(:old_best_answer) { create(:answer, question: question, best: true) }

     let(:another_question_answer) { create(:answer, :with_question) }

     it 'set new best answer' do
       answer.make_best

       expect(answer.reload.best).to be_truthy
     end

     it 'previos the best answer is not best' do
       answer.make_best

       expect(old_best_answer.reload.best).to be_falsey
     end

     it 'question has only one the best answer' do
       answer.make_best
       answer2.make_best

       expect(question.answers.where(best: true).count).to eq(1)
     end

     it 'each question is able to has the best answer' do
       answer.make_best
       another_question_answer.make_best

       expect(question.answers.where(best: true).count).to eq(1)
       expect(another_question_answer.question.answers.where(best: true).count).to eq(1)
     end
   end
end
