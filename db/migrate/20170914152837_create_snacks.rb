class CreateSnacks < ActiveRecord::Migration[5.1]
  def change
    create_table :snacks do |t|
      t.string :name
      t.decimal :price, precision: 5, scale: 2
    end
  end
end
