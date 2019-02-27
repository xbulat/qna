require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer)   { create(:answer, :with_question) }
  let(:user)   { create(:user) }

  let(:answer_with_question) { create(:answer, :with_question, user: user)}

  describe 'POST #create' do
    before { login(user) }

    let!(:question) { create(:question) }

    context 'with valid attributes' do
      it 'saves a new Answer of Question in the database' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer, :valid) }, format: :js }.to change(Answer, :count).by(1)
      end

      it 'redirects to question show' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js
        expect(response).to redirect_to question_path(controller.question)
      end

      it 'created Answer belongs to Question' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js
        expect(assigns(:answer).question).to eq question
      end

      it 'created Answer belongs to current_user' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js
        expect(assigns(:answer).user).to eq user
      end

    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }, format: :js}.to_not change(Answer, :count)
      end

      it 'render questions#show' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }, format: :js
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
        expect { delete :destroy, params: { id: answer }, format: :js }.to change(Answer, :count).by(-1)
      end

      it 'redirect to question#show' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to answer.question
      end
    end

    context 'not author tries' do
      before { login(user) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { id: answer }, format: :js }.to_not change(Answer, :count)
      end

      it 'redirect to question#show' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to answer.question
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user) }

    context 'with valid attributes' do
      before { patch :update, params: { id: answer_with_question, answer: { body: 'MyNewBody' } }, format: :js }

      it 'changes answer attributes' do
        answer_with_question.reload
        expect(answer_with_question.body).to eq 'MyNewBody'
      end

      it 'renders update view' do

        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      it 'does not change answer attributes' do
        expect { patch :update, params: { id: answer_with_question, answer: attributes_for(:answer, :invalid) }, format: :js}.to_not change(answer_with_question, :body)
      end

      it 'renders answers' do
        patch :update, params: { id: answer_with_question, answer: attributes_for(:answer, :invalid) }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'not author with valid attributes' do
      it 'does not change answer attributes' do
        expect { patch :update, params: { id: answer, answer: attributes_for(:answer) }, format: :js}.to_not change(answer, :body)
      end

      it 'renders status forbidden' do
        patch :update, params: { id: answer, answer: attributes_for(:answer) }, format: :js
        expect(response.response_code).to eq(403)
      end
    end

  end

  describe 'PATCH #best' do
    before { login(user) }

    context 'set new best answer' do
      let!(:best_answer) { create(:answer, question: question, best: true) }
      let(:answers) { create_list(:answer, 5, user: user, question: question) }

      before do
        login(question.user)
        patch :best, params: { id: answers.last }, format: :js
      end

      it 'path answer as best' do
        answers.last.reload

        expect(answers.last.best).to be_truthy
      end

      it 'previous best answer is reset' do
        best_answer.reload

        expect(best_answer.best).to be_falsey
      end

      it 'render template' do
        expect(response).to render_template :best
      end
    end

    context 'not author of question' do
      let(:answer) { create(:answer, :with_question) }
      let(:user) { create(:user) }

      before do
        login(user)
        patch :best, params: { id: answer }, format: :js
      end

      it 'does not make the best answer' do
        expect(answer.best).to be_falsey
      end

      it 'renders status forbidden' do
        expect(response.response_code).to eq(403)
      end
    end
  end
end
