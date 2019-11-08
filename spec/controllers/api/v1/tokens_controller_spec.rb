# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::TokensController, type: :controller do
  describe "GET #create" do
    it "returns http :success" do
      get :create, params: { firebase: { token: "123" } }
      expect(response).to have_http_status(:success)
    end

    it "return http :unprocessable_entity" do
      get :create, params: { firebase: { not_found: "123" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
