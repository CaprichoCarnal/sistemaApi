class Api::V1::ReportsController < ApplicationController
  def count_available_for_cutting
    count = RawMaterial.where(available: "Disponible para Despiece").count
  
    response = {
      status: "success",
      message: "Informe de Materias Primas Disponibles para Despiece",
      data: {
        count: count
      }
    }
  
    render json: response
  end

  def sales_report
    @sales_data = Sale.joins(:customer).select(
      'customers.fiscal_name AS customer_fiscal_name',
      'customers.commercial_name AS customer_commercial_name',
      'sales.total AS sales_total',
      'sales.vat AS sales_vat',
      'sales.id'
    )

    respond_to do |format|
      format.json { render json: @sales_data }
    end
  end

  def purchases_report
    @purchase_data_supplies = PurchaseSupply.joins(:supplier)
                                            .select(
                                              "'supplies' AS purchase_type",
                                              'suppliers.id AS supplier_id',
                                              'suppliers.fiscal_name AS supplier_fiscal_name',
                                              'suppliers.commercial_name AS supplier_commercial_name',
                                              'purchase_supplies.id AS purchase_id',
                                              'purchase_supplies.invoice_code AS invoice_code',
                                              'SUM(purchase_supplies.total) AS total_purchase',
                                              'purchase_supplies.vat AS purchase_vat',
                                              'purchase_supplies.status AS purchase_status',
                                              'purchase_supplies.payment AS purchase_payment'
                                            )
                                            .group(
                                              'suppliers.id',
                                              'suppliers.fiscal_name',
                                              'suppliers.commercial_name',
                                              'purchase_supplies.id',
                                              'purchase_supplies.invoice_code',
                                              'purchase_supplies.vat',
                                              'purchase_supplies.status',
                                              'purchase_supplies.payment'
                                            )

    @purchase_data_raw_material = RawMaterialPurchase.joins(:supplier)
                                                     .select(
                                                       "'raw_material' AS purchase_type",
                                                       'suppliers.id AS supplier_id',
                                                       'suppliers.fiscal_name AS supplier_fiscal_name',
                                                       'suppliers.commercial_name AS supplier_commercial_name',
                                                       'raw_material_purchases.id AS purchase_id',
                                                       'raw_material_purchases.invoice_code AS invoice_code',
                                                       'SUM(raw_material_purchases.total) AS total_purchase',
                                                       'raw_material_purchases.vat AS purchase_vat',
                                                       'raw_material_purchases.status AS purchase_status',
                                                       'raw_material_purchases.payment AS purchase_payment'
                                                     )
                                                     .group(
                                                       'suppliers.id',
                                                       'suppliers.fiscal_name',
                                                       'suppliers.commercial_name',
                                                       'raw_material_purchases.id',
                                                       'raw_material_purchases.invoice_code',
                                                       'raw_material_purchases.vat',
                                                       'raw_material_purchases.status',
                                                       'raw_material_purchases.payment'
                                                     )

    @purchase_data = @purchase_data_supplies + @purchase_data_raw_material

    respond_to do |format|
      format.json { render json: @purchase_data }
    end
  end

  def pending_invoices_report
    @pending_invoices = Invoice.joins(:sale)
                               .where(status: 'Pendiente')
                               .select(
                                 'sales.id AS sale_id',
                                 'sales.customer_id AS customer_id',
                                 'invoices.number AS invoice_number',
                                 'invoices.date AS invoice_date',
                                 'invoices.total AS invoice_total'
                               )

    respond_to do |format|
      format.json { render json: @pending_invoices }
    end
  end

  def pending_purchases_report
    @pending_purchases = PurchaseSupply.joins(:supplier)
                                       .where(status: ['Pendiente', 'Pendiente por pagar'])
                                       .select(
                                         "'supplies' AS purchase_type",
                                         'suppliers.id AS supplier_id',
                                         'suppliers.fiscal_name AS supplier_fiscal_name',
                                         'suppliers.commercial_name AS supplier_commercial_name',
                                         'purchase_supplies.id AS purchase_id',
                                         'purchase_supplies.invoice_code AS invoice_code',
                                         'purchase_supplies.date_of_purchase AS purchase_date',
                                         'purchase_supplies.total AS purchase_total'
                                       )

    @pending_purchases_raw_material = RawMaterialPurchase.joins(:supplier)
                                                        .where(status: ['Pendiente', 'Pendiente por pagar'])
                                                        .select(
                                                          "'raw_material' AS purchase_type",
                                                          'suppliers.id AS supplier_id',
                                                          'suppliers.fiscal_name AS supplier_fiscal_name',
                                                          'suppliers.commercial_name AS supplier_commercial_name',
                                                          'raw_material_purchases.id AS purchase_id',
                                                          'raw_material_purchases.invoice_code AS invoice_code',
                                                          'raw_material_purchases.date_of_purchase AS purchase_date',
                                                          'raw_material_purchases.total AS purchase_total'
                                                        )

    @pending_purchases = @pending_purchases + @pending_purchases_raw_material

    respond_to do |format|
      format.json { render json: @pending_purchases }
    end
  end
  
  def count_cutting_finished
    count = RawMaterial.where(available: "Despiece Finalizado").count
  
    response = {
      status: "success",
      message: "Informe de Materias Primas Despiece Finalizado",
      data: {
        count: count
      }
    }
  
    render json: response
  end
  
  def count_partial_cutting
    count = RawMaterial.where(available: "Despiece Parcial").count
  
    response = {
      status: "success",
      message: "Informe de Materias Primas Despiece Parcial",
      data: {
        count: count
      }
    }
  
    render json: response
  end

  def best_selling_products_weekly
    start_date = Date.today.beginning_of_week
    end_date = Date.today.end_of_week
  
    weekly_sales = Sale.where(date: start_date..end_date).pluck(:id)
    best_selling_items = SaleItem.where(sale_id: weekly_sales)
                                 .group(:product_sold)
                                 .sum(:quantity)
                                 .sort_by { |_, quantity| -quantity }
                                 .to_h
  
    response = {
      status: "success",
      message: "Informe de los productos más vendidos por semana",
      data: {
        best_selling_products: best_selling_items
      }
    }
  
    render json: response
  end
  
  def best_selling_products_monthly
    start_date = Date.today.beginning_of_month
    end_date = Date.today.end_of_month
  
    monthly_sales = Sale.where(date: start_date..end_date).pluck(:id)
    best_selling_items = SaleItem.where(sale_id: monthly_sales)
                                 .group(:product_sold)
                                 .sum(:quantity)
                                 .sort_by { |_, quantity| -quantity }
                                 .to_h
  
    response = {
      status: "success",
      message: "Informe de los productos más vendidos por mes",
      data: {
        best_selling_products: best_selling_items
      }
    }
  
    render json: response
  end
  
  def best_selling_products_yearly
    start_date = Date.today.beginning_of_year
    end_date = Date.today.end_of_year
  
    yearly_sales = Sale.where(date: start_date..end_date).pluck(:id)
    best_selling_items = SaleItem.where(sale_id: yearly_sales)
                                 .group(:product_sold)
                                 .sum(:quantity)
                                 .sort_by { |_, quantity| -quantity }
                                 .to_h
  
    response = {
      status: "success",
      message: "Informe de los productos más vendidos por año",
      data: {
        best_selling_products: best_selling_items
      }
    }
  
    render json: response
  end
  
  
  def paid_purchases_report_raw_materials
    paid_purchases_raw_materials = RawMaterialPurchase.where(status: "Pagado")
  
    response = {
      status: "success",
      message: "Informe de Compras Pagadas - Materias Primas",
      data: {
        purchases: paid_purchases_raw_materials
      }
    }
  
    render json: response
  end
  
  def unpaid_purchases_report_raw_materials
    unpaid_purchases_raw_materials = RawMaterialPurchase.where(status: "Pendiente")
  
    response = {
      status: "success",
      message: "Informe de Compras por Pagar - Materias Primas",
      data: {
        purchases: unpaid_purchases_raw_materials
      }
    }
  
    render json: response
  end

  
  def paid_purchases_report_supplies
    paid_purchases_supplies = PurchaseSupply.where(status: "Pagado")
  
    response = {
      status: "success",
      message: "Informe de Compras Pagadas - Suministros",
      data: {
        purchases: paid_purchases_supplies
      }
    }
  
    render json: response
  end

  
  def unpaid_purchases_report_supplies
    unpaid_purchases_supplies = PurchaseSupply.where(status: "Pendiente")
  
    response = {
      status: "success",
      message: "Informe de Compras por Pagar - Suministros",
      data: {
        purchases: unpaid_purchases_supplies
      }
    }
  
    render json: response
  end

  def iva_balance_raw_materials
    raw_materials = RawMaterialPurchase.all
  
    total_iva_balance_raw_materials = 0
  
    raw_materials.each do |raw_material|
      iva_percentage = raw_material.vat.to_f / 100  # Convertir el porcentaje de IVA a decimal
      iva_balance = raw_material.total * iva_percentage
      total_iva_balance_raw_materials += iva_balance
    end
  
    response = {
      status: "success",
      message: "Saldo en IVA - Materias Primas",
      data: {
        balance: total_iva_balance_raw_materials
      }
    }
  
    render json: response
  end

  def calculate_total_purchase
    raw_material = RawMaterialPurchase.all
    total_rawmaterial = raw_material.sum(&:total) 
  
    supply = PurchaseSupply.all
    total_supply = supply.sum(&:total)
  
    response = {
      status: "success",
      message: "Saldo en Compras",
      data: {
        RawMaterial_Purchase: total_rawmaterial, # Add a comma here
        Purchase_Supplies: total_supply          # Add a comma here
      }
    }
  
    render json: response
  end
  
  def calculate_total_sales_by_month
    sales = Sale.all.group_by { |sale| sale.date.beginning_of_month }
  
    total_sales_by_month = {}
  
    sales.each do |month, month_sales|
      total_sales = month_sales.sum(&:total)
      total_sales_by_month[month.strftime('%B %Y')] = total_sales
    end
  
    response = {
      status: "success",
      message: "Total Sales per Month",
      data: {
        total_sales_by_month: total_sales_by_month
      }
    }
  
    render json: response
  end
  

  def calculate_total_sales
    sales = Sale.all
  
    total_sales = sales.sum(&:total)
  
    response = {
      status: "success",
      message: "Total Sales",
      data: {
        total: total_sales
      }
    }
  
    render json: response
  end
  
  
  def iva_balance_supplies
    supplies = PurchaseSupply.all
  
    total_iva_balance_supplies = 0
  
    supplies.each do |supply|
      iva_percentage = supply.vat.to_f / 100  # Convertir el porcentaje de IVA a decimal
      iva_balance = supply.total * iva_percentage
      total_iva_balance_supplies += iva_balance
    end
  
    response = {
      status: "success",
      message: "Saldo en IVA - Suministros",
      data: {
        balance: total_iva_balance_supplies
      }
    }
  
    render json: response
  end

  def invoices_status_report
    pending_count = Invoice.where(status: "pendiente").count
    paid_count = Invoice.where(status: "pagado").count
  
    response = {
      status: "success",
      message: "Informe de Facturas por Estado",
      data: {
        pending: pending_count,
        paid: paid_count
      }
    }
  
    render json: response
  end
  
  def generate_report
    pending_count = Invoice.where(status: "Pendiente").count
    paid_count = Invoice.where(status: "Cobrada").count
    canceled_count = Invoice.where(status: "Cancelada").count
    refunded_count = Invoice.where(status: "Cobrada con devolución").count
  
    sales = Sale.all
    total_sales = sales.sum(&:total)
  
    raw_material = RawMaterialPurchase.all
    total_rawmaterial = raw_material.sum(&:total)
  
    supply = PurchaseSupply.all
    total_supply = supply.sum(&:total)
  
    paid_raw_materials = RawMaterialPurchase.where(status: "Pagado").count
    partial_paid_raw_materials = RawMaterialPurchase.where(status: "Pago parcial").count
    unpaid_raw_materials = RawMaterialPurchase.where(status: "Pendiente por pagar").count
  
    paid_supplies = PurchaseSupply.where(status: "Pagado").count
    partial_paid_supplies = PurchaseSupply.where(status: "Pago parcial").count
    unpaid_supplies = PurchaseSupply.where(status: "Pendiente por pagar").count
  
    response = {
      status: "success",
      message: "Reporte Completo",
      data: {
        invoices_status: {
          pendiente: pending_count,
          cobrada: paid_count,
          cancelada: canceled_count,
          cobrada_con_devolucion: refunded_count
        },
        total_sales: {
          status: "success",
          message: "Total de Ventas",
          data: {
            total: total_sales
          }
        },
        total_purchase: {
          status: "success",
          message: "Saldo en Compras",
          data: {
            RawMaterial_Purchase: total_rawmaterial,
            Purchase_Supplies: total_supply
          }
        },
        purchase_reports: {
          raw_materials: {
            paid: paid_raw_materials,
            partial_paid: partial_paid_raw_materials,
            unpaid: unpaid_raw_materials
          },
          supplies: {
            paid: paid_supplies,
            partial_paid: partial_paid_supplies,
            unpaid: unpaid_supplies
          }
        }
      }
    }
  
    render json: response
  end
  
  
  
  
  
  
end
