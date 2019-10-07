require 'rails_helper'

# test only Active Record
RSpec.describe SopsController, type: :controller do
  describe 'GET index' do
    it 'returns 200' do
      get :index

      expect(response.status).to eq 200
    end
  end
end
