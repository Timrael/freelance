class Bid < ActiveRecord::Base
  default_scope order('created_at')

  belongs_to :project
  belongs_to :user

  attr_accessible :description, :price

  validates_presence_of :project_id, :user_id, :description
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validate :project_author_cannot_be_bid_author
  validate :project_cannot_have_chosen_bid, on: :create

  state_machine initial: :unselected do
    event :select_it do
      transition :unselected => :selected, if: lambda {|bid| bid.project.on_competition?}
    end

    after_transition any => :selected do |bid, transition|
      bid.project.launch
    end
  end

  protected

  def project_author_cannot_be_bid_author
    if self.user == project.author
      errors.add(:user_id, "can't be same person as project author")
    end
  end

  def project_cannot_have_chosen_bid
    unless project.on_competition?
      errors.add(:project_id, "has chosen bid. You can't add new one.")
    end
  end
end
