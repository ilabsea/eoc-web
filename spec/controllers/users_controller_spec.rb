# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :controller do
  render_views

  before(:each) do
    sign_in FactoryBot.create(:user)
  end

  describe "#update_locale" do
    it "response with success" do
      post :update_locale, params: { user: { locale: "km" } }
      expect(response).to have_http_status(200)
    end

    it "update locale" do
      post :update_locale, params: { user: { locale: "km" } }
      expect(User.first.locale).to eq("km")
    end
  end
end
