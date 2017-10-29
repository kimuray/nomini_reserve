class AddRemandReasonToExchanges < ActiveRecord::Migration[5.1]
  def change
    add_column :exchanges, :remand_reason, :text
  end
end
