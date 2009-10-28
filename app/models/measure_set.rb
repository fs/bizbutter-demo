class MeasureSet < ActiveRecord::Base
  belongs_to :deal
  belongs_to :author

  validates_presence_of :deal_id, :title, :author_id
  validates_inclusion_of :published, :in => [true, false]
end