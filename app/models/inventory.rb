class Inventory < ApplicationRecord
  belongs_to :item, polymorphic: true, optional: true
  validates :category, presence: true

  after_update :update_cut_weight, if: :weight_changed?

  def update_cut_weight
    if item_type == "Cut"
      cut = item
      cut.update(weight: weight) if cut.present?
    end
  end
  
end
