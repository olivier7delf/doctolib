class Schedule < ApplicationRecord
  has_one :user
  belongs_to :doctor

  # validates :user, uniqueness: { scope: :dt }
  # validates :user, prese
  validates :doctor, uniqueness: { scope: :dt }


  def self.take_an_appointment(dt, doctor_id, user_id, appointment_type, duration=30, logs=false)
    # ex:
    # dt = DateTime.now.change({ hour: 9, min: 0, sec: 0 })
    # doctor_id: Doctor.first.id
    # user_id = User.first.id
    # appointment_type = "rhumatologue"
    # Take an appointment

    schedule = Schedule.find_by(doctor: doctor_id, dt: dt)
    if schedule
      if !schedule.user_id.nil? && schedule.user_id != user_id
        puts "Schedule appointment already taken by another user !" if logs
        return false
      end

      schedule.user_id = user_id
      schedule.appointment_type = appointment_type
      schedule.duration = duration

      if schedule.valid?
         schedule.save!
         puts "Schedule appointment created" if logs
         return true
      else
        puts "Cannot save appointment: #{schedule}" if logs
        return false
      end
    else
      puts "Cannot save appointment: schedule is nil #{schedule}" if logs
      return false
    end
  end
end
