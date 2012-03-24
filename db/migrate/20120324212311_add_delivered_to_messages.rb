class AddDeliveredToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :delivered, :boolean

  end
end
