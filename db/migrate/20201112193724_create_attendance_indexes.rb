class CreateAttendanceIndexes < ActiveRecord::Migration[6.0]
  def change
    add_index 'attendances', 'attendance_type_code'
    add_index 'attendances', 'lost_reason_code'
    add_index 'attendances', "date_trunc('day', start_at)"
  end
end
