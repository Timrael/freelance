# encoding: utf-8
require "spec_helper"

describe ProjectsController, "restricting access on edit, update, destroy" do
  let(:project) { FactoryGirl.create(:project) }
  let(:new_project) { FactoryGirl.build(:project) }
  let(:not_the_author) { FactoryGirl.create(:user) }

  context "when current user is NOT project author" do
    before do
      sign_in not_the_author
    end

    it "restricts access to edit action" do
      get :edit, id: project.id

      response.response_code.should be 403
    end

    it "restricts access to update action" do
      put :update, id: project.id, project: FactoryGirl.attributes_for(:project)

      response.response_code.should be 403
    end

    it "restricts access to destroy action" do
      delete :destroy, id: project.id

      response.response_code.should be 403
    end
  end

  context "when current user is project author" do
    before do
      sign_in project.author
    end

    it "does NOT restrict access to edit action" do
      get :edit, id: project.id

      response.response_code.should_not be 403
    end

    it "does NOT restrict access to update action" do
      put :update, id: project.id, project: FactoryGirl.attributes_for(:project)

      response.response_code.should_not be 403
    end

    it "does NOT restrict access to destroy action" do
      delete :destroy, id: project.id

      response.response_code.should_not be 403
    end
  end
end
