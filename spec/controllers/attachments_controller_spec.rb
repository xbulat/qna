require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  describe 'DELETE #destroy' do
      let!(:question) { create(:question, :with_file) }
      let!(:another_question) { create(:question, :with_file) }

      context 'author tries' do
        before { login(question.user) }

        it 'deletes attachment' do
          expect { delete :destroy, params: { id: question.files.first.id }, format: :js }.to change(question.files, :count).by(-1)
        end

        it 'deletes foreign attachment' do
          delete :destroy, params: { id: another_question.files.first.id }, format: :js

          expect(response.response_code).to eq(403)
        end

        it 'redirect to question#show' do
          delete :destroy, params: { id: question.files.first.id }, format: :js

          expect(response).to redirect_to question_path(question)
        end
      end

      it 'Not Authenticated user tries deletes a attachment' do
        delete :destroy, params: { id: question.files.first.id }, format: :js

        expect(response.response_code).to eq(401)
      end
  end
end
