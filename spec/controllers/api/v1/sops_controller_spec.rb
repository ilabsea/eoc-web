# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::SopsController, type: :controller do
  context "Unauthorize request" do
    describe "GET #index" do
      it "renders errors unauthorize request" do
        get :index
        expect(response.parsed_body).to be_unauthorize
      end
    end

    describe "GET #show" do
      it "renders errors unauthorize request" do
        get :show, params: { id: create(:sop).id }
        expect(response.parsed_body).to be_unauthorize
      end
    end
  end

  context "Authorize" do
    before do
      request.headers["Authorization"] = "bearer #{Rails.application.credentials.app[:server_secret_key_base]}"
    end

    describe "GET #index" do
      it "renders result" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #show" do
      it "renders result" do
        get :show, params: { id: create(:sop).id }
        expect(response).to have_http_status(:success)
      end
    end
  end
end
