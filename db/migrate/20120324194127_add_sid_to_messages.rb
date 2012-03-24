class AddSidToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :sid, :string
  end
end
