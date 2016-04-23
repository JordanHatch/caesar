class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :application, index: true, null: false
      t.string :intent, null: false
      t.string :name, null: false
    end
  end
end
