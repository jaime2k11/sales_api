class CreateSales < ActiveRecord::Migration[8.0]
  def change
    create_table :sales do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_price
      t.datetime :date_sold

      t.timestamps
    end
  end
end
