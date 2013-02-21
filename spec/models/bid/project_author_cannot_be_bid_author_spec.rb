# encoding: utf-8
require "spec_helper"

describe Bid, "#project_author_cannot_be_bid_author" do
  let(:bid) { FactoryGirl.build(:bid) }
  context "when bid author is a project author" do
    before do
      bid.user = bid.project.author
    end

    it "is NOT valid" do
      bid.should_not be_valid
    end

    it "has validation error on bid author" do
      bid.valid?
      bid.errors.should include(:user_id)
    end
  end

  context "when bid author is NOT a project author" do
    it "is valid" do
      bid.should be_valid
    end
  end
end
