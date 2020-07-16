class Play < ApplicationRecord
  belongs_to :image

  validates_presence_of :timer_value

  delegate :attachment, to: :image, prefix: true
end
