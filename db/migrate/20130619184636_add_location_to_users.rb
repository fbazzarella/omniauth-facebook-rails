class AddLocationToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :location
    end
  end
end
