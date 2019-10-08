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

  describe 'PUT update' do
    it 'updates sop' do
      sop = create(:sop, name: 'old sop')
      new_sop = { name: 'new sop' }

      put :update, params: { id: sop.id, sop: { name: 'new sop' } }

      expect( assigns(:sop).name ).to eq( new_sop[:name] )
    end

    it 'cannot update duplicate sop' do
      sop1 = create(:sop, name: 'sop 1')
      sop2 = create(:sop, name: 'sop 2')

      put :update, params: { id: sop1.id, sop: { name: sop2.name } }

      expect( subject ).to render_template(:edit)
    end
  end

  it 'deletes sop' do
    sop = create(:sop, name: 'unwanted sop')
    delete :destroy, params: { id: sop.id }
    expect(subject).to redirect_to(sops_path)
  end
end
