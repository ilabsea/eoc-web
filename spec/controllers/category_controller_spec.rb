# frozen_string_literal: true

require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  render_views

  before(:each) do
    sign_in FactoryBot.create(:user)
  end

  describe "#index" do
    let!(:category) { create(:category) }
    let!(:sop) { create(:sop, category_id: nil) }

    it "should render index page" do
      get :index
      expect(subject).to render_template(:index)
    end
  end

  describe "#new" do
    it "shows new" do
      get :new
      expect(subject).to render_template(:new)
      expect(response.status).to eq 200
    end
  end

  describe "#create" do
    context "when valid data" do
      it "create new category" do
        post :create, params: { category: { name: "test", tags: "anytag" } }
        expect(subject).to redirect_to(category_path(assigns(:category)))
      end
    end

    context "when duplicate name" do
      let!(:category) { create(:category) }

      it "should show errors message" do
        post :create, params: { category: { name: category.name, tags: "" } }
        expect(subject).to render_template(:new)
        expect(response.body).to match(/Name has already been taken/im)
      end
    end

    context "when name is empty" do
      it "should show errors message" do
        post :create, params: { category: { name: "", tags: "" } }
        expect(subject).to render_template(:new)
        expect(response.body).to match(/Name can&#39;t be blank/im)
      end
    end
  end

  describe "#show" do
    let!(:category) { create(:category) }

    it "should render show" do
      get :show, params: { id: category.id }
      expect(subject).to render_template(:show)
      expect(response.body).to match(/#{category.name}/)
    end
  end

  describe "#edit" do
    let!(:category) { create(:category) }

    it "should render show" do
      get :edit, params: { id: category.id }
      expect(subject).to render_template(:edit)
      expect(response.body).to match(/value="#{category.name}"/)
    end
  end

  describe "#update" do
    context "valid name" do
      let!(:category) { create(:category, name: "old") }

      it "should update category name" do
        put :update, params: { id: category.id, category: { name: "new", tags: "" } }
        expect(assigns(:category).name).to eq("new")
        expect(subject).to redirect_to(category_path(category))
      end
    end

    context "duplicate name" do
      let!(:category) { create(:category, name: "old") }
      let!(:category_2) { create(:category, name: "cat 2") }

      it "should show errors message" do
        put :update, params: { id: category.id, category: { name: category_2.name, tags: "" } }
        expect(subject).to render_template(:edit)
        expect(response.body).to match(/Name has already been taken/)
      end
    end

    context "empty category name" do
      let!(:category) { create(:category, name: "old") }

      it "should show errors message" do
        put :update, params: { id: category.id, category: { name: "", tags: "" } }
        expect(subject).to render_template(:edit)
        expect(response.body).to match(/Name can&#39;t be blank/)
      end
    end
  end

  describe "#destroy" do
    context "root category" do
      let!(:category) { create(:category) }

      it "delete record" do
        delete :destroy, params: { id: category.id }
        expect(subject).to redirect_to(categories_path)
      end
    end

    context "child category" do
      let!(:category) { create(:category) }
      let!(:child) { create(:category, parent_id: category.id) }

      it "redirect to category page" do
        delete :destroy, params: { id: child.id }
        expect(subject).to redirect_to(category_path(category))
      end
    end

    context "has child category" do
      let!(:category) { create(:category) }
      let!(:child) { create(:category, parent_id: category.id) }

      it "should throw errors" do
        delete :destroy, params: { id: category.id }
        expect(subject.request.flash[:alert]).to eq ["category is not empty"]
      end
    end

    context "has sop" do
      let!(:category) { create(:category) }
      let!(:sop) { create(:sop, category_id: category.id) }

      it "should throw errors" do
        delete :destroy, params: { id: category.id }
        expect(subject.request.flash[:alert]).to eq ["category is not empty"]
      end
    end
  end
end
