# encoding: utf-8
require "spec_helper"

describe Bid, "#launch_project" do
  let(:bid) { FactoryGirl.create(:bid) }

  context "when it has been chosen" do
    before do
      bid.select_it
    end

    it "launches project" do
      bid.project.in_progress?.should be_true
    end
  end

  context "when it has NOT been chosen" do
    it "does NOT launch project" do
      bid.project.on_competition?.should be_true
    end
  end
end
