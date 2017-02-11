class CreateAlerts < ActiveRecord::Migration[5.0]
  def change
    create_table :alerts do |t|
      t.column :uuid, :string
      t.column :name, :string
      t.column :description, :string
      t.column :query, :text
      t.column :user_id, :integer

      t.timestamps

      t.index :uuid, unique: true
    end
  end
end
