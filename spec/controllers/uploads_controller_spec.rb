# frozen_string_literal: true

require "rails_helper"

RSpec.describe UploadsController, type: :controller do
  render_views

  before(:each) do
    sign_in FactoryBot.create(:user)
  end

  describe "#index" do
    it "should render index page" do
      get :index
      expect(:subject).to render_template(:index)
    end
  end

  describe "#validate" do
    context "invalid attached file" do
      it "renders upload when no attach file" do
        post :validate
        expect(subject).to render_template("uploads/_upload")
        expect(subject.request.flash[:alert]).to eq I18n.t("views.uploads.invalid_import_file")
      end

      it "renders upload when no wrong attachment type" do
        post :validate, params: { zip_file: fixture_file_upload(file_path("test.xlsx"), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") }

        expect(subject).to render_template("uploads/_upload")
        expect(subject.request.flash[:alert]).to eq(I18n.t("views.uploads.invalid_import_file"))
      end
    end
  end
end
