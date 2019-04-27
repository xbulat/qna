require 'rails_helper'

RSpec.shared_examples 'voted' do
  let(:user) { create(:user) }
  let(:author) { create(:user) }
  let!(:model) { create(described_class.controller_name.classify.constantize, :complete, user: author) }

  describe 'PUT #like' do

    context 'not-author of object' do
      before { login(user) }

      it 'tries to like object' do
        expect { post :like, params: { id: model } }.to change(Rating, :count)
      end
    end

    context 'author of object' do
      before { login(author) }

      it 'tries to like object' do
        post :like, params: { id: model }
        expect(response.response_code).to eq(403)
      end
    end
  end

  describe 'PUT #dislike' do

    context 'not-author of object' do
      before { login(user) }

      it 'tries to dislike object' do
        expect { post :dislike, params: { id: model } }.to change(Rating, :count)
      end
    end

    context 'author of object' do
      before { login(author) }

      it 'tries to dislike object' do
        post :dislike, params: { id: model }
        expect(response.response_code).to eq(403)
      end
    end
  end

  describe 'DELETE #revoke' do
    context 'user tries' do
      before { login(user) }

      it 'revokes his vote' do
        post :like, params: { id: model }
        expect { delete :revoke, params: { id: model } }.to change(Rating, :count).by(-1)
      end
    end
  end
end
