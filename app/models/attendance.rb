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

  scope :by_day, ->(day) { where("date_trunc('day', start_at) = ?", day.to_date) }
  scope :by_period, ->(start_at, end_at) { where("date_trunc('day', start_at) BETWEEN ? AND ?", start_at.to_date, end_at.to_date) }

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

  def self.lost_reasons_count_by(filters: nil, group_by: nil)
    # base query
    query = Attendance.select(
                        'lost_reasons.code as lost_reason_code, ' \
                        'lost_reasons.description as lost_reason_description,' \
                        'count(*) as attendances_count'
                      ).group(
                        'lost_reasons.code,' \
                        'lost_reasons.description'
                      )

    # joins
    if group_by&.include?(:brand) || (filters && filters[:brand_ids])
      query = query.joins(:lost_reason, seller: { store: :brand })
    elsif group_by&.include?(:store)
      query = query.joins(:lost_reason, seller: :store)
    elsif group_by&.include?(:seller)
      query = query.joins(:lost_reason, :seller)
    else
      query = query.joins(:lost_reason)
    end

    # filters
    if filters
      query = query.by_day(filters[:date]) if filters[:date]
      query = query.by_period(filters[:start_at], filters[:end_at]) if filters[:start_at] && filters[:end_at]
      query = query.where('brands.id IN (?)', filters[:brand_ids]) if filters[:brand_ids]
    end

    # group by
    if group_by.present?
      if group_by.include?(:seller)
        query = query.select('sellers.id as seller_id, sellers.name as seller_name')
                     .group('sellers.id, sellers.name')
      end

      if group_by.include?(:store)
        query = query.select('stores.id as store_id, stores.name as store_name')
                     .group('stores.id, stores.name')
      end

      if group_by.include?(:brand)
        query = query.select('brands.id as brand_id, brands.name as brand_name')
                     .group('brands.id, brands.name')
      end

      if group_by.include?(:date)
        query = query.select('date_trunc(\'day\', start_at) as date')
                     .group('date_trunc(\'day\', start_at)')
      end
    end

    query
  end
end
