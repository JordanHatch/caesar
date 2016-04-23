class AddEmailToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :email, :string
  end
end
