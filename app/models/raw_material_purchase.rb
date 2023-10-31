class RawMaterialPurchase < ApplicationRecord
  belongs_to :supplier
  belongs_to :family, optional: true
  after_create :create_raw_materials
  after_update :update_related_invoices

  def update_related_invoices
    related_invoices = RawMaterialPurchase.where(invoice_code: invoice_code)
                                        .where.not(id: id)

    related_invoices.update_all(
      date_of_purchase: date_of_purchase,
      supplier_id: supplier_id,
      item: item,
      family_id: family_id,
      description: description,
      lot: lot,
      quantity: quantity,
      price: price,
      discount: discount,
      total: total,
      vat: vat,
      status: status
    )
  end

  def create_raw_materials
    if cut
      RawMaterial.create!(
        raw_material_purchase: self,
        family: family,
        supplier: supplier,
        description: description,
        born_date: '',
        born_in: '',
        raised_in: '',
        slaughter_date: '',
        slaughtered_in: '',
        crotal: '',
        lot: lot,
        weight: sprintf('%.2f', weight), # Formatear el peso antes de guardarlo
        temperature: '',
        classification: '',
        available: 'No',
        material_type: 'Corte'
      )
    elsif family_id == 21
      RawMaterial.create!(
        raw_material_purchase: self,
        family: family,
        supplier: supplier,
        description: description,
        born_date: '',
        born_in: '',
        raised_in: '',
        slaughter_date: '',
        slaughtered_in: '',
        crotal: '',
        lot: lot,
        weight: sprintf('%.2f', weight), # Formatear el peso antes de guardarlo
        temperature: '',
        classification: '',
        available: 'Disponible para Despiece',
        material_type: 'Canal'
      )
    else
      quantity.times do
        RawMaterial.create!(
          raw_material_purchase: self,
          family: family,
          supplier: supplier,
          description: description,
          channel_number: '',
          born_date: '',
          born_in: '',
          raised_in: '',
          slaughter_date: '',
          slaughtered_in: '',
          crotal: '',
          lot: lot,
          weight: sprintf('%.2f', weight), # Formatear el peso antes de guardarlo
          temperature: '',
          classification: '',
          available: 'Disponible para Despiece',
          material_type: 'Canal'
        )
      end
    end
  end
end
