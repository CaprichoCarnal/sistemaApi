class Invoice < ApplicationRecord
  belongs_to :sale
  attribute :status, :string, default: 'pendiente'
end
