class Project < ActiveRecord::Base
  default_scope order('created_at DESC')

  CONDITION_ON_COMPETITION = "on competition"
  CONDITION_IN_PROGRESS    = "in progress"
  CONDITION_CLOSED         = "closed"

  belongs_to :author, :class_name => "User", :foreign_key => "author_id"

  attr_accessible :title, :description

  before_validation do |p|
    p.condition ||= CONDITION_ON_COMPETITION
  end

  class << self
    def on_competition
      where(:condition => CONDITION_ON_COMPETITION)
    end
  end
end
