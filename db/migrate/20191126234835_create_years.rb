class CreateYears < ActiveRecord::Migration[6.0]
  def change
    create_table :years do |t|
      t.integer :year
      t.integer :company_id
      t.integer :stats_profile_id

      t.timestamps
    end
  end
end
