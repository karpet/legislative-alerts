namespace :alerts do

  desc 'check for new activity and send emails'
  task check: :environment do
    User.find_in_batches.with_index do |users, batch|
      User.transaction do
        users.each do |user|
          checker = AlertChecker.new(user: user)
          checker.run
        end
      end
    end
  end

  desc 'report usage'
  task report: :environment do
    User.find_in_batches.with_index do |users, batch|
      users.each do |user|
        puts "User #{user.id} has #{user.alerts.count} alerts"
        user.alerts.each do |alert|
          puts " #{alert.alert_type} #{alert.id} last sent #{alert.last_sent_at} last run #{alert.last_run_at}"
        end
      end
    end
  end
end
