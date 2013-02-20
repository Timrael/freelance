class Project < ActiveRecord::Base
  default_scope order('created_at DESC')

  CONDITION_ON_COMPETITION = "on competition"
  CONDITION_IN_PROGRESS    = "in progress"
  CONDITION_CLOSED         = "closed"

  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  has_many :bids

  attr_accessible :title, :description

  validates_presence_of :author_id, :title, :description
  validates :condition, :inclusion =>
      {:in => [CONDITION_ON_COMPETITION, CONDITION_IN_PROGRESS, CONDITION_CLOSED]}

  before_validation do |p|
    p.condition ||= CONDITION_ON_COMPETITION
  end

  class << self
    def on_competition
      where(:condition => CONDITION_ON_COMPETITION)
    end
  end

  def have_chosen_bid?
    self.bids.where(:chosen => true).present?
  end
end
