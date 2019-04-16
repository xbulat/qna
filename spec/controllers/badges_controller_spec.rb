require 'rails_helper'

RSpec.describe BadgesController, type: :controller do
  let(:user)   { create(:user) }
  let(:badges) { create_list(:badge, 3, user: user) }

  describe 'GET #index' do
    before do
      login(user)
      get :index
    end

    it 'populates an array of all badges' do
      expect(controller.badges).to eq badges
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end
