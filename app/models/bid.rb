class Bid < ActiveRecord::Base
  default_scope order('created_at')

  belongs_to :project
  belongs_to :user

  attr_accessible :description, :price

  validates_presence_of :project_id, :user_id, :description
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates :chosen, inclusion: {in: [true, false]}
  validate :project_author_cannot_be_bid_author, :chosen_bid_cannot_be_more_than_one
  validate :project_cannot_have_chosen_bid, on: :create

  before_validation :set_default_attributes
  before_update :launch_project, if: :have_been_chosen?

  def choose
    self.chosen = true
    self.save
  end

  protected

  def project_author_cannot_be_bid_author
    errors.add(:user_id, "can't be same person as project author") if
        self.project.present? && self.user == project.author
  end

  def chosen_bid_cannot_be_more_than_one
    errors.add(:chosen, "can't be more than one per project") if
        self.project.present? && self.have_been_chosen? && self.project.have_chosen_bid?
  end

  def project_cannot_have_chosen_bid
    errors.add(:project_id, "has chosen bid. You can't add new one.") if
        self.project.present? && self.project.have_chosen_bid?
  end

  def set_default_attributes
    self.chosen ||= false
    true
  end

  def have_been_chosen?
    self.changed_attributes.include?("chosen") && self.chosen?
  end

  def launch_project
    self.project.condition = Project::CONDITION_IN_PROGRESS
    self.project.save
  end
end
