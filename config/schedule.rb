set :output, 'log/cron.log'

# 金額確認メール
every 1.day, at: '0:30 am' do
  runner "Batches::PaymentConfirmBatch.exec"
end
