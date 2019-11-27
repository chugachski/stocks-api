class CreateStatsProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :stats_profiles do |t|
      t.float :volatility
      t.float :annual_change
      t.float :avg
      t.float :min
      t.float :max

      t.timestamps
    end
  end
end
