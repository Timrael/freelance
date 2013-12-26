# encoding: utf-8
require "spec_helper"

describe BidsController, "#choose" do
  let(:bid) { FactoryGirl.create(:bid) }
  let(:project) { bid.project }
  let(:not_the_author) { FactoryGirl.create(:user) }

  context "when current user is NOT project author" do
    before do
      sign_in not_the_author
      put :select, project_id: project.id, bid_id: bid.id
    end

    it "restricts access to the action" do
      response.response_code.should == 403
    end
  end

  context "when current user is project author" do
    before do
      sign_in project.author
      put :select, project_id: project.id, bid_id: bid.id
    end

    it "does NOT restrict access to the action" do
      response.response_code.should_not be 403
    end

    it "chooses bid for the project" do
      bid.reload.selected?.should be_true
    end
  end
end
