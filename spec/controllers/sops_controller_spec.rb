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

  it "deletes sop" do
    sop = create(:sop, name: "unwanted sop")
    delete :destroy, params: { id: sop.id }
    expect(subject).to redirect_to(sops_path)
  end

  it "GET upload" do
    get :upload
    expect(response.status).to eq 200
  end

  describe "POST import" do
    context "invalid attached file" do
      it "renders upload when no attach file" do
        post :import
        expect(subject).to redirect_to(upload_sops_path)
        expect(subject.request.flash[:alert]).to eq "Invalid import file!"
      end

      it "renders upload when no wrong attachment type" do
        post :import, params: { zip_file: fixture_file_upload(file_path("test.xlsx"), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") }

        expect(subject).to redirect_to(upload_sops_path)
        expect(subject.request.flash[:alert]).to eq "Invalid import file!"
      end
    end

    context "bad zip file" do
      it "renders upload when no excel file in zip" do
        post :import, params: { zip_file: fixture_file_upload(file_path("archive-no-excel.zip"), "application/zip") }

        expect(subject).to redirect_to(upload_sops_path)
        expect(subject.request.flash[:alert]).to eq I18n.t(".sop_import_service.not_found")
      end

      it "renders upload when zip is damage" do
        post :import, params: { zip_file: fixture_file_upload(file_path("bad_zip.zip"), "application/zip") }

        expect(subject).to redirect_to(upload_sops_path)
        expect(subject.request.flash[:alert]).to eq "Zip end of central directory signature not found"
      end
    end

    context "correct zip file" do
      it "import zip file" do
        post :import, params: { zip_file: fixture_file_upload(file_path("Archive.zip"), "application/zip") }

        expect(subject).to redirect_to(categories_path)
        expect(subject.request.flash[:notice]).to eq "Import success!"
      end
    end
  end
end
