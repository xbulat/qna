require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe 'DELETE #destroy' do
      let!(:question) { create(:question) }
      let!(:link) { create(:link, linkable: question) }

      let!(:another_question) { create(:question) }
      let!(:another_link) { create(:link, linkable: another_question) }

      context 'author tries' do
        before { login(question.user) }

        it 'deletes link' do
          expect { delete :destroy, params: { id: link.id }, format: :js }.to change(question.links, :count).by(-1)
        end

        it 'deletes foreign attachment' do
          delete :destroy, params: { id: another_link.id }, format: :js

          expect(response.response_code).to eq(403)
        end

        it 'redirect to question#show' do
          delete :destroy, params: { id: link.id }, format: :js

          expect(response).to redirect_to question_path(question)
        end
      end

      it 'Not Authenticated user tries deletes a link' do
        delete :destroy, params: { id: link.id }, format: :js

        expect(response.response_code).to eq(401)
      end
  end
end
