# == Schema Information
#
# Table name: attendance_types
#
#  id          :bigint           not null, primary key
#  code        :string           not null
#  description :string           not null
#
class AttendanceType < ApplicationRecord
end
