class CreateStatsProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :stats_profiles do |t|
      t.references :company, null: false, foreign_key: true
      t.string :year
      t.float :min
      t.float :max
      t.float :avg
      t.float :ending
      t.float :volatility
      t.float :annual_change

      t.timestamps
    end
  end
end
