class Channel < ApplicationRecord
  belongs_to :family
  belongs_to :supplier
  attribute :available, :boolean, default: true
end
