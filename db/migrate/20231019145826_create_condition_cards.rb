class CreateConditionCards < ActiveRecord::Migration[7.0]
  def change
    create_table :condition_cards do |t|
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
