class Invoice < ApplicationRecord
  belongs_to :sale
  attribute :status, :string, default: 'pendiente'

  after_save :generate_pdf

  def generate_pdf
    template_path = Rails.root.join('app', 'assets', 'pdf_templates', 'template.pdf')
    invoice_path = Rails.root.join('app', 'assets', 'pdf_templates', 'invoice.pdf')

    FileUtils.cp(template_path, invoice_path)

    pdf = Prawn::Document.new(template: invoice_path)

    # Lógica para posicionar los datos en la plantilla
    # ...

    pdf.render_file(invoice_path)
  end

  
end
