namespace :alerts do

  desc 'check for new activity and send emails'
  task check: :environment do
    stats = { sent: 0, users: 0 }
    User.find_in_batches.with_index do |users, batch|
      User.transaction do
        users.each do |user|
          checker = AlertChecker.new(user: user)
          alerts_sent = checker.run
          stats[:sent] += alerts_sent.length
          if alerts_sent.length > 0
            stats[:users] += 1
          end
        end
      end
    end
    AlertMailer.admin_alert(stats).deliver_now
  end

  desc 'report usage'
  task report: :environment do
    User.find_in_batches.with_index do |users, batch|
      users.each do |user|
        puts "User #{user.id} has #{user.alerts.count} alerts"
        user.alerts.each do |alert|
          puts " #{alert.alert_type} #{alert.id} status:#{alert.status} sent:#{alert.last_sent_at} run:#{alert.last_run_at}"
        end
      end
    end
  end
end
