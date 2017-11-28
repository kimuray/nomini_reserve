set :output, 'log/cron.log'

# 金額確認メール
every 1.day, at: '0:30 am' do
  runner "Batches::PaymentConfirmBatch.exec"
end

# 強制決済
every 1.day, at: '1:00 am' do
  runner "Batches::ForcePaymentBatch.exec"
end
