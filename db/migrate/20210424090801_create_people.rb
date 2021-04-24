class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string   :name, null: false, default: ''
      t.datetime :birthday, null: false
      t.datetime :day_of_death, null: false
      t.text     :note

      t.timestamps
    end
  end
end
