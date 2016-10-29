class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :sender, index: true, null: false
      t.references :recipient, index: true, null: false
      t.string :content, null: false, default: ''
      t.timestamps
    end
  end
end
