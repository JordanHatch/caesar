class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :owner, null: false
      t.string :change, null: false
    end
  end
end
