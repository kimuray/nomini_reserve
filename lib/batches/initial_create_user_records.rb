require 'csv'

class Batches::InitialCreateUserRecords
  def self.exec
    customer_csv = CSV.table('customer_sheet.csv')
    customer_csv.each do |customer|
      user = User.new
      user.email = customer[:email]
      user.password = SecureRandom.hex(6)
      user.l_name_kana = customer[:last_name_kana]
      user.f_name_kana = customer[:first_name_kana]
      user.phone_number = customer[:phone_number].gsub('-', '')
      user.save!
    end
  end
end
