class CreateSystemSettings < ActiveRecord::Migration[5.1]
  def change
    ActiveRecord::Base.transaction do
      create_table :system_settings do |t|
        t.string :config_name, index: true, null: false
        t.integer :value, null: false

        t.timestamps
      end

      SystemSetting.create!(config_name: 'exchange', value: 5_000)
      SystemSetting.create!(config_name: 'introduction', value: 2_000)
    end
  end
end
