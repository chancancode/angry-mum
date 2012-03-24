class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.boolean :incoming
      t.string :from
      t.string :to
      t.string :body

      t.timestamps
    end
  end
end
