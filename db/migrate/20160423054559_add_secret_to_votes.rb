class AddSecretToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :secret, :string, null: false
  end
end
