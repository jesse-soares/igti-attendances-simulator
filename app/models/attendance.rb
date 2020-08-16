# == Schema Information
#
# Table name: attendances
#
#  id                 :bigint           not null, primary key
#  end_at             :datetime         not null
#  start_at           :datetime         not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  attendance_type_id :bigint           not null
#  seller_id          :bigint           not null
#  store_id           :bigint           not null
#
class Attendance < ApplicationRecord
  belong_to :attendance_type
  belong_to :seller
  belong_to :store
end
