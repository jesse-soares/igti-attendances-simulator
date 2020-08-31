# == Schema Information
#
# Table name: attendances
#
#  id                   :bigint           not null, primary key
#  attendance_type_code :string           not null
#  end_at               :datetime         not null
#  lost_reason_code     :string
#  start_at             :datetime         not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  product_id           :bigint
#  seller_id            :bigint           not null
#  store_id             :bigint           not null
#
class Attendance < ApplicationRecord
  belongs_to :seller
  belongs_to :store
  belongs_to :attendance_type, foreign_key: :attendance_type_code, primary_key: :code
  belongs_to :lost_reason, foreign_key: :lost_reason_code, primary_key: :code, optional: true
  belongs_to :product, optional: true

  def self.create_random(store, date, lost_reasons=nil, attendance_types=nil)
    start_at = date.to_time + rand((7*3600)..(23*3600)) # between 7:00 and 23:00
    end_at   = start_at + rand(30..(25*60))             # 30 seg a 25 min
    product  = nil
    lost_reason = nil

    type = [[:success]*rand(5), [:unsuccess]*rand(5), :exchange].flatten.sample # random with weight

    if type == :unsuccess
      product = store.brand.products.sample
      lost_reason = (lost_reasons || LostReason.all).sample
    end

    Attendance.create!(
      store: store,
      seller: store.sellers.sample,
      attendance_type: attendance_types.present? ? attendance_types[type] : AttendanceType.find(type),
      product: product,
      lost_reason: lost_reason,
      start_at: start_at,
      end_at: end_at
    )
  end
end
