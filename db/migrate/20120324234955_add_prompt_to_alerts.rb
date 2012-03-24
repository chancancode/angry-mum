class AddPromptToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :prompt, :string

  end
end
