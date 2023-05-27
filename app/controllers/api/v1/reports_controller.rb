class Api::V1::ReportsController < ApplicationController
    def sales_report
        sales = Sale.includes(:customer, :sale_items).all
    
        report = {
          sales: sales.map { |sale| format_sale(sale) }
        }
    
        render json: report
      end
    
      def purchases_report
        purchases = RawMaterialPurchase.includes(:supplier).all
    
        report = {
          purchases: purchases.map { |purchase| format_purchase(purchase) }
        }
    
        render json: report
      end
    
      def inventory_report
        inventories = Inventory.includes(:item).all
    
        report = {
          inventories: inventories.map { |inventory| format_inventory(inventory) }
        }
    
        render json: report
      end
    
      private
    
      def format_sale(sale)
        {
          id: sale.id,
          date: sale.date,
          total: sale.total,
          customer: format_customer(sale.customer),
          items: sale.sale_items.map { |item| format_sale_item(item) }
        }
      end
    
      def format_customer(customer)
        {
          id: customer.id,
          name: customer.name,
          email: customer.email,
          phone: customer.phone
          # Agrega los campos adicionales que desees incluir en el informe
        }
      end
    
      def format_sale_item(item)
        {
          id: item.id,
          quantity: item.quantity,
          price: item.price,
          inventory: format_inventory(item.inventory)
        }
      end
    
      def format_purchase(purchase)
        {
          id: purchase.id,
          date_of_purchase: purchase.date_of_purchase,
          supplier: format_supplier(purchase.supplier),
          # Agrega los campos adicionales que desees incluir en el informe
        }
      end
    
      def format_inventory(inventory)
        {
          id: inventory.id,
          item_type: inventory.item_type,
          item_id: inventory.item_id,
          category: inventory.category,
          lot: inventory.lot,
          weight: inventory.weight,
          expiration_date: inventory.expiration_date
          # Agrega los campos adicionales que desees incluir en el informe
        }
      end
    
      def format_supplier(supplier)
        {
          id: supplier.id,
          fiscal_name: supplier.fiscal_name,
          commercial_name: supplier.commercial_name,
          email: supplier.email,
          phone: supplier.phone
          # Agrega los campos adicionales que desees incluir en el informe
        }
      end
end
