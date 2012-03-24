class AddFieldsToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :reason, :string

  end
end
