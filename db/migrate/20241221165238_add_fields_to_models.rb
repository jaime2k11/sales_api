class AddFieldsToModels < ActiveRecord::Migration[7.0]
  def change
    # Campos para User
    add_column :users, :name, :string

    # Campos para Sale
    add_column :sales, :name, :string

    # Campos para Product
    add_column :products, :description, :text
    add_column :products, :stock, :integer, default: 0
  end
end
