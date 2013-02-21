# encoding: utf-8
require "spec_helper"

describe Bid, "#launch_project" do
  let(:bid) { FactoryGirl.create(:bid) }

  context "when it has been chosen" do
    before do
      bid.choose
    end

    it "launches project" do
      bid.project.condition.should eq Project::CONDITION_IN_PROGRESS
    end
  end

  context "when it has NOT been chosen" do
    it "does NOT launch project" do
      bid.project.condition.should eq Project::CONDITION_ON_COMPETITION
    end
  end
end
