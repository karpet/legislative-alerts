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

end
