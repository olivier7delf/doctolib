class CreateDoctors < ActiveRecord::Migration[6.0]
  def change
    create_table :doctors do |t|
      t.string :specialty
      t.string :address
      t.string :city
      t.string :phone
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
