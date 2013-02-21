# encoding: utf-8
require "spec_helper"

describe Bid, "#chosen_bid_cannot_be_more_than_one" do
  let(:main_bid) { FactoryGirl.create(:bid) }
  let(:same_project_bid) { FactoryGirl.create(:bid, :project_id => main_bid.project_id) }

  context "when project has already chosen bid" do
    before do
      same_project_bid.choose
      main_bid.chosen = true
    end

    it "is NOT valid" do
      main_bid.should_not be_valid
    end

    it "has validation error on chosen" do
      main_bid.valid?
      main_bid.errors.should include(:chosen)
    end
  end

  context "when project does NOT have chosen bid" do
    it "is valid" do
      main_bid.should be_valid
    end
  end
end
