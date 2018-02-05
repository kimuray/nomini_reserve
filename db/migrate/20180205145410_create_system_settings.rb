class CreateSystemSettings < ActiveRecord::Migration[5.1]
  def change
    ActiveRecord::Base.transaction do
      create_table :system_settings do |t|
        t.string :physical_name, index: true, null: false
        t.string :logical_name, null: false
        t.integer :value, null: false

        t.timestamps
      end

      SystemSetting.create!(logical_name: '換金値', physical_name: 'exchange', value: 5_000)
      SystemSetting.create!(logical_name: '招待ポイント', physical_name: 'introduction', value: 2_000)
    end
  end
end
