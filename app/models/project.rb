class Project < ActiveRecord::Base
  default_scope order('created_at DESC')

  belongs_to :author, class_name: "User", foreign_key: "author_id"
  has_many :bids

  attr_accessible :title, :description

  validates_presence_of :author_id, :title, :description

  state_machine initial: :on_competition do
    event :launch do
      transition :on_competition => :in_progress
    end

    event :close do
      transition all - [:closed] => :closed
    end
  end
end
