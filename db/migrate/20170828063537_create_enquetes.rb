class CreateEnquetes < ActiveRecord::Migration[5.1]
  def change
    create_table :enquetes do |t|
      t.references :reservation, foreign_key: true
      t.date       :answer_date
      t.timestamps
    end
  end
end
