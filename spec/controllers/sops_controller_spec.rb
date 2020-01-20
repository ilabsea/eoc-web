# frozen_string_literal: true

require "rails_helper"

# test only Active Record
RSpec.describe SopsController, type: :controller do
  before(:each) do
    sign_in FactoryBot.create(:user)
  end

  describe "GET new" do
    it "shows new" do
      expect(response.status).to eq 200
    end
  end

  describe "POST create" do
    it "create new sop" do
      post :create, params: { sop: { name: "test", category_id: nil, tags: "tags", file: nil } }
      expect(subject).to redirect_to(sop_path(assigns(:sop)))
    end

    it "cannot create SOP with duplicate name" do
      create(:sop, name: "dup")
      post :create, params: { sop: { name: "dup", category_id: nil, tags: "tags", file: nil } }

      expect(subject).to render_template(:new)
    end
  end

  describe "GET edit" do
    it "shows edit" do
      expect(response.status).to eq 200
    end
  end

  describe "PUT update" do
    it "updates sop" do
      sop = create(:sop, name: "old sop")
      new_sop = { name: "new sop" }

      put :update, params: { id: sop.id, sop: { name: "new sop", tags: "" } }

      expect(assigns(:sop).name).to eq(new_sop[:name])
    end

    it "cannot update duplicate sop" do
      sop1 = create(:sop, name: "sop 1")
      sop2 = create(:sop, name: "sop 2")

      put :update, params: { id: sop1.id, sop: { name: sop2.name, tags: "" } }

      expect(subject).to render_template(:edit)
    end
  end

  describe "#destroy" do
    it "delete record" do
      sop = create(:sop)
      delete :destroy, params: { id: sop.id }
      expect(Sop.count).to eq(0)
    end

    it "redirect to root category after destroy" do
      sop = create(:sop)
      delete :destroy, params: { id: sop.id }
      expect(subject).to redirect_to(categories_path)
    end

    it "redirect to specific category page" do
      sop = create(:sop, :with_category)
      delete :destroy, params: { id: sop.id }
      expect(subject).to redirect_to(category_path(sop.category_id))
    end
  end
end
