class AddOwnerToDogs < ActiveRecord::Migration[5.2]
  def change
    add_column :dogs, :owner, :integer
  end
end
