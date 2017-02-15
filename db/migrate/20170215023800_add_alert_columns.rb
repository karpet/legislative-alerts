class AddAlertColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :alerts, :last_sent_at, :datetime
  end
end
