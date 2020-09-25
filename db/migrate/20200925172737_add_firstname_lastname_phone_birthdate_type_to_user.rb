class AddFirstnameLastnamePhoneBirthdateTypeToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :phone, :string
    add_column :users, :birthdate, :datetime
    add_column :users, :type, :string
  end
end
