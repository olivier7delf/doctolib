# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# query speciality of a doctor
# Doctor.all.first.doctor_specialities.first.speciality.name
require_relative "../app/models/schedule"

Schedule.destroy_all
puts "DESTROYED : Schedule"

DoctorSpeciality.destroy_all
puts "DESTROYED : DoctorSpeciality"

Speciality.destroy_all
puts "DESTROYED : Speciality"

Doctor.destroy_all
puts "DESTROYED : User"

User.destroy_all
puts "DESTROYED : User"




User.create!(firstname: "max", lastname: "Dupond2",
  email: "max.dupond2@gmail.com", phone: "0610001000", password: "123132")
User.create!(firstname: "antoine", lastname: "jibo",
  email: "antoine.jibo@gmail.com", phone: "0610001001", password: "123132")

User.create!(firstname: "jean", lastname: "eude",
  email: "jean.eude@gmail.com", phone: "0655566688", password: "123132",
  is_doctor: true)
User.create!(firstname: "marc", lastname: "follichon",
  email: "marc.follichon@gmail.com", phone: "0655566689", password: "123132",
  is_doctor: true)

puts "Users created"

Doctor.create!(phone: "0122223333",
  user: User.find_by(firstname: "jean", lastname: "eude"),
   city: "bordeaux", address: "3 boulevard de la guinguette")
Doctor.create!(phone: "0122223334",
  user: User.find_by(firstname: "marc", lastname: "follichon"),
   city: "bordeaux", address: "3 boulevard de la riviere")

puts "Doctors created"

SPECIALITIES = ['rhumatologue', 'généraliste', 'oncologue']
SPECIALITIES.each do |speciality|
  Speciality.create(name: speciality)
end

puts "Specialities created"

Doctor.all.each_with_index do |doctor, index|
  puts doctor
  DoctorSpeciality.create(doctor_id: doctor.id, speciality: Speciality.find_by(name: SPECIALITIES[index % 3]))
end

puts "doctor_specialities created"

# Create available schedules, patients will be able to choosen within them
# 5 day by week, 8-12h , 14-18h of the next month

def get_next_date(date, available_hours)
  # available_hours, ex : [(start_morning, end_morning), (start_afternoon, end_afternoon)]
  # 48 times because we want to try until the next day, same hour:
  # we add 0.5 hour each time so we have to add
  next_date = date + 30.minutes
  48.times do
    available_hours.each do |interval|
      if (next_date.hour >= interval[0]) && (next_date.hour < interval[1])
        return next_date
      end
    end
    next_date += 30.minutes
  end
end



# date = DateTime.now.change({ hour: 12, min: 0, sec: 0 })
# get_next_date(date, available_hours)
# date_origin = DateTime.now.change({ hour: 8, min: 0, sec: 0 })

available_hours = [[8, 12], [14, 18]]
new_doc = 0
Doctor.all.each_with_index do |doctor, index|
  date = DateTime.now.change({ hour: 7, min: 0, sec: 0 })
  while date < DateTime.now.change({ hour: 23, min: 0, sec: 0 })
    date = get_next_date(date, available_hours)
    schedule = Schedule.create(doctor_id: doctor.id, dt: date)
    if schedule.valid?
      schedule.save!
    else
      puts "Cannot save doctor: #{doctor.id} at #{date}"
    end
  end
end
puts "Schedule created"

# Take an appointment

Schedule.take_an_appointment(
  dt=DateTime.now.change({ hour: 9, min: 0, sec: 0 }),
  doctor_id=Doctor.first.id,
  user_id=User.first.id,
  appointment_type="rhumatologue",
  duration=30,
  logs=true
  )
puts "Schedule took 1"


Schedule.take_an_appointment(
  dt=DateTime.now.change({ hour: 9, min: 0, sec: 0 }),
  doctor_id=Doctor.first.id,
  user_id=User.first.id,
  appointment_type="rhumatologue",
  duration=30,
  logs=true
  )
puts "Schedule took 2"


# dt = DateTime.now.change({ hour: 9, min: 0, sec: 0 })
# schedule = Schedule.find_by(doctor: Doctor.first.id, dt: dt)
# schedule.user_id = User.first.id
# schedule.duration = 30
# schedule.appointment_type = "rhumatologue"
# if schedule.valid?
#    schedule.save!
# else
#   puts "Cannot save appointment: #{schedule}"
# end

# puts "Schedule appointment created"










def test_get_next_date

  def check_dates_equalities(date_1, date_2)
    if date_1 != date_2
      raise "error #{date_1} != #{date_2} (the good one)"
    else
      puts "Great #{date_1} == #{date_2} (the good one)"
    end
  end

  available_hours = [[8, 12], [14, 18]]

  date = DateTime.now.change({ hour: 12, min: 0, sec: 0 })
  next_date = get_next_date(date, available_hours)
  next_date_expected = DateTime.now.change({ hour: 14, min: 0, sec: 0 })
  check_dates_equalities(next_date, next_date_expected)

  date = DateTime.now.change({ hour: 8, min: 0, sec: 0 })
  next_date = get_next_date(date, available_hours)
  next_date_expected = DateTime.now.change({ hour: 8, min: 30, sec: 0 })
  check_dates_equalities(next_date, next_date_expected)

  date = DateTime.now.change({ hour: 18, min: 0, sec: 0 })
  next_date = get_next_date(date, available_hours)
  next_date_expected = DateTime.now.change({ hour: 8, min: 0, sec: 0 }) + 1.day
  check_dates_equalities(next_date, next_date_expected)

end
