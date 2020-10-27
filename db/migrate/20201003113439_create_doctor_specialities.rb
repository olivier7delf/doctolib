class CreateDoctorSpecialities < ActiveRecord::Migration[6.0]
  def change
    create_table :doctor_specialities do |t|
      t.references :speciality, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
