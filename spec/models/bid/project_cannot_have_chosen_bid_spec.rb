# encoding: utf-8
require "spec_helper"

describe Bid, "#project_cannot_have_chosen_bid" do
  let(:same_project_bid) { FactoryGirl.create(:bid) }
  let(:main_bid) { FactoryGirl.build(:bid, project_id: same_project_bid.project_id) }

  context "when project has chosen bid" do
    before do
      same_project_bid.select_it
    end

    it "is NOT valid" do
      main_bid.should_not be_valid
    end

    it "has validation error on project" do
      main_bid.valid?
      main_bid.errors.should include(:project_id)
    end
  end

  context "when project does NOT have chosen bid" do
    it "is valid" do
      main_bid.should be_valid
    end
  end
end
