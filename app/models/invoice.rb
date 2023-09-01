class Invoice < ApplicationRecord
  belongs_to :sale
  attribute :status, :string, default: 'Pendiente'

  

  
end
