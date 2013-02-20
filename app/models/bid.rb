class Bid < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  attr_accessible :description, :price

  validates_presence_of :project_id, :user_id, :description
  validates_numericality_of :price, :greater_than_or_equal_to => 0
  validates :chosen, :inclusion => {:in => [true, false]}
  validate :project_author_cannot_be_bid_author, :chosen_bid_cannot_be_more_than_one

  before_validation :set_default_attributes
  before_update :launch_project, :if => :have_been_chosen?

  protected

  def project_author_cannot_be_bid_author
    errors.add(:user_id, "can't be same person as project author") if
        self.user == project.author
  end

  def chosen_bid_cannot_be_more_than_one
    errors.add(:chosen, "can't be more than one per project") if
        self.chosen && self.project.have_chosen_bid?
  end

  def set_default_attributes
    self.chosen ||= false
    true
  end

  def have_been_chosen?
    self.changed_attributes.include?(:chosen) && self.chosen?
  end

  def launch_project
    self.project.condition = Project::CONDITION_IN_PROGRESS
    self.project.save
  end
end
