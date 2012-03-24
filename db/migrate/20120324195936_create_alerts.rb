class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :user_id
      t.datetime :start
      t.integer :timeout
      t.string :fallback_name
      t.string :fallback_phone
      t.string :fallback_phone_normalised

      t.timestamps
    end
  end
end
