class CreateEnqueteAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :enquete_answers do |t|
      t.references :enquete_item, foreign_key: true
      t.references :enquete, foreign_key: true
      t.text       :string_value
      t.integer    :integer_value
      t.boolean    :boolean_value

      t.timestamps
    end
  end
end
