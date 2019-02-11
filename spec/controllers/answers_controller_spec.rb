require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer)   { create(:answer) }
  let(:user)   { create(:user) }

  let(:answer_with_question) { create(:answer, :with_question, user: user)}

  describe 'POST #create' do
    before { login(user) }

    let!(:question) { create(:question) }

    context 'with valid attributes' do
      it 'saves a new Answer of Question in the database' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer, :valid) } }.to change(Answer, :count).by(1)
      end

      it 'redirects to question show' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(controller.question)
      end

      it 'created Answer belongs to Question' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(assigns(:answer).question).to eq question
      end

      it 'created Answer belongs to current_user' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(assigns(:answer).user).to eq user
      end

    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) } }.to_not change(Answer, :count)
      end

      it 'render questions#show' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, :with_question) }
    before { login(answer.user) }

    context 'author tries' do
      before { login(answer.user) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
      end

      it 'redirect to question#show' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to answer.question
      end
    end

    context 'not author tries' do
      before { login(user) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end

      it 'redirect to question#show' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to answer.question
      end
    end

  end
end
