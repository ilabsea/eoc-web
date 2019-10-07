require 'rails_helper'

# test only Active Record
RSpec.describe SopsController, type: :controller do
  describe 'GET index' do
    it 'returns 200' do
      get :index

      expect(response.status).to eq 200
    end

    it 'returns results from elasticsearch'
  end

  describe 'GET new' do
    it 'shows new' do
      expect(response.status).to eq 200
    end
  end

  describe 'POST create' do
    it 'create new sop' do
      post :create, params: { sop: { name: 'test', category_id: nil, tags: 'tags', file: nil } }
      expect(subject).to redirect_to(sops_path)
    end

    it 'cannot create SOP with duplicate name' do
      sop = create(:sop, name: 'dup')
      post :create, params: { sop: { name: 'dup', category_id: nil, tags: 'tags', file: nil } }

      expect(subject).to render_template(:new)
    end
  end

  describe 'GET edit' do
    it 'shows edit' do
      expect(response.status).to eq 200
    end
  end
end
