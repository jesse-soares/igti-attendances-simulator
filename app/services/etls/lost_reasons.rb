class Etls::LostReasons
  def self.generate_by_date(date:)
    Rails.logger.info "Starting ETL [LostReasons] [date=#{date}]"

    return if Mongo::LostReasons.where(date: date).size > 0

    result = self.query(date: date)

    rows = result.to_a.map { |res| res.attributes.symbolize_keys.slice!(:id) }

    Rails.logger.info "Migrating #{rows.size} rows at [date=#{date}]"

    Mongo::LostReasons.create! rows if rows.size > 0

    Rails.logger.info "Finish [date=#{date}]!"
  end

  private

  def self.query(date:)
    Attendance.joins(:lost_reason, seller: { store: :brand })
              .by_day(date)
              .select(
                'lost_reasons.code as lost_reason_code, ' \
                'lost_reasons.description as lost_reason_description,' \
                'sellers.id as seller_id,' \
                'sellers.name as seller_name,' \
                'stores.id as store_id,' \
                'stores.name as store_name,' \
                'brands.id as brand_id,' \
                'brands.name as brand_name,' \
                'date_trunc(\'day\', start_at) as date,' \
                'count(*) as attendances_count'
              ).group(
                'lost_reasons.code,' \
                'lost_reasons.description,' \
                'sellers.id,' \
                'sellers.name,' \
                'stores.id,' \
                'stores.name,' \
                'brands.id,' \
                'brands.name,' \
                'date_trunc(\'day\', start_at)'
              )
  end
end
