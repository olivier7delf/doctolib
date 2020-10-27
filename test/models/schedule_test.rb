require 'test_helper'
require_relative "../../app/models/schedule"
require_relative "../../app/models/doctor"
require_relative "../../app/models/user"

# load "../../db/seeds.rb"
# Rails.application.load_seed
class ScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  #fail to create appointment
  def setup
    # find a cleaner way, ex:  describe ...
    Rails.application.load_seed
  end

  logs = false

  test "take_an_appointment" do
    assert Schedule.take_an_appointment(
      dt=DateTime.now.change({ hour: 9, min: 0, sec: 0 }),
      doctor_id=Doctor.first.id,
      user_id=User.first.id,
      appointment_type="rhumatologue",
      duration=30,
      logs=logs
    )
  end

  test "fail take_an_appointment because not in available hours" do
    assert !Schedule.take_an_appointment(
      dt=DateTime.now.change({ hour: 7, min: 0, sec: 0 }),
      doctor_id=Doctor.first.id,
      user_id=User.first.id,
      appointment_type="rhumatologue",
      duration=30,
      logs=logs
    )
  end

  test "fail take_an_appointment because already taken by another user" do
    assert !Schedule.take_an_appointment(
      dt=DateTime.now.change({ hour: 9, min: 0, sec: 0 }),
      doctor_id=Doctor.first.id,
      user_id=User.last.id,
      appointment_type="rhumatologue",
      duration=30,
      logs=logs
    )
  end

  test "fail take_an_appointment missing info appointment_type" do
    assert !Schedule.take_an_appointment(
      dt=DateTime.now.change({ hour: 9, min: 0, sec: 0 }),
      doctor_id=Doctor.first.id,
      user_id=User.last.id,
      appointment_type=nil,
      duration=30,
      logs=true
    )
  end
end



