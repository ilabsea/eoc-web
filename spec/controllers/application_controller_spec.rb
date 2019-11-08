# frozen_string_literal: true

require "rails_helper"

# test only Active Record
RSpec.describe ApplicationController, type: :controller do
  controller do
    def index; end
  end

  describe "user not login" do
    it "redirect to signin page" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end
end
