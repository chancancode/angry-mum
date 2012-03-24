class AddSidToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :sid, :string

  end
end
