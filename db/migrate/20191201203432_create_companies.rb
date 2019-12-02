class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name, index: {unique: true}
      t.string :symbol, index: {unique: true}

      t.timestamps
    end
  end
end
