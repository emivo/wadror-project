class CreateProductQuantityInOrders < ActiveRecord::Migration
  def change
    create_table :product_quantity_in_orders do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
