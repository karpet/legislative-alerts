class AddAlertDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :alerts, :last_run_at, :datetime
    add_column :alerts, :checksum, :string
    add_column :alerts, :type, :integer, default: 0
  end
end
