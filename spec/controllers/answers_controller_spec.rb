require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer)   { create(:answer) }
  let(:user)   { create(:user) }

  let(:answer_with_question) { create(:answer, :with_question, user: user)}

  describe 'GET #index' do
    let(:answers) { create_list(:answer, 5, question: question, user: user) }

    before { get :index, params: { question_id: question } }

    it 'populates an array of all answers of question' do
      expect(controller.answers).to eq answers
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before { login(user) }

    before { get :new, params: { question_id: question } }

    it 'assigns a new Answer to Question' do
      expect(controller.answer).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

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

    it 'deletes the answer' do
      expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
    end

    it 'redirect to question#show' do
      delete :destroy, params: { id: answer }
      expect(response).to redirect_to answer.question
    end
  end
end
