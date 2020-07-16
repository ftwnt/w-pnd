class Image < ApplicationRecord
  has_one_attached :attachment
  has_many :plays, dependent: :destroy
end
