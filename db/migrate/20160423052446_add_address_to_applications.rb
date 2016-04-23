class AddAddressToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :address, :string
  end
end
