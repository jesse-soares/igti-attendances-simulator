class Etls::LostReasons
  def self.generate_by_date(date:)
    Rails.logger.info "Starting ETL [LostReasons] [date=#{date}]"

    # delete data if exists at date to regenerate
    if Mongo::LostReasons.where(date: date).size > 0

      Rails.logger.info "cleaning exisiting LostReasons at [date=#{date}]"
      Mongo::LostReasons.where(date: date).destroy_all
    end

    result = Attendance.lost_reasons_count_by(
      filters: { date: date },
      group_by: [:seller, :store, :brand, :date]
    )

    rows = result.to_a.map { |res| res.attributes.symbolize_keys.slice!(:id) }

    Rails.logger.info "Migrating #{rows.size} rows at [date=#{date}]"

    Mongo::LostReasons.create! rows if rows.size > 0

    Rails.logger.info "Finish [date=#{date}]!"
  end
end
