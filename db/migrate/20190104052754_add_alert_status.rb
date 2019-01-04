class AddAlertStatus < ActiveRecord::Migration[5.0]
  def change
    add_column :alerts, :status, :string, default: 'active'
  end
end
