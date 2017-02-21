class AlertType < ActiveRecord::Migration[5.0]
  class Alert < ActiveRecord::Base
  end

  def up
    add_column :alerts, :type, :string
    execute "UPDATE alerts SET type = 'Alert::Bill' where alert_type = 0"
    execute "UPDATE alerts SET type = 'Alert::Search' where alert_type = 1"
    remove_column :alerts, :alert_type
    rename_column :alerts, :type, :alert_type
  end
end
