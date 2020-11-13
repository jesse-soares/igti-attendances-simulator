module Benchmarks
  class LostReasons
    def self.run_all
      Rails.logger.info 'Benchmark: by_date_and_brand ----------------------------'
      self.by_date_and_brand(date: '2020-01-01')
      Rails.logger.info ''

      Rails.logger.info 'Benchmark: by_period_and_brand (1 month) ----------------------------'
      self.by_period_and_brand(period: '2020-01-01'..'2020-01-31')
      Rails.logger.info ''

      Rails.logger.info 'Benchmark: by_date ----------------------------'
      self.by_date(date: '2020-01-01')
      Rails.logger.info ''

      Rails.logger.info 'Benchmark: by_period (1 month) ----------------------------'
      self.by_period(period: '2020-01-01'..'2020-01-31')
      Rails.logger.info ''

      Rails.logger.info 'Benchmark: by_period (3 months) ----------------------------'
      self.by_period(period: '2020-01-01'..'2020-03-31')
      Rails.logger.info ''

      Rails.logger.info 'Benchmarks: all ----------------------------'
      self.all
      Rails.logger.info ''
    end

    def self.by_date_and_brand(n: 10, date: Date.today, brand_id: 1)
      ServiceUtils.disable_database_logs

      Benchmark.bm do |benchmark|
        benchmark.report('postgresql') do
          n.times do
            Attendance.lost_reasons_count_by(
              filters: { date: date, brand_ids: brand_id }
            ).to_a
          end
        end

        benchmark.report('mongodb') do
          n.times do
            Mongo::LostReasons.lost_reasons_count_by(
              filters: { date: date.to_date, brand_id: brand_id }
            ).to_a
          end
        end
      end
    end

    def self.by_period_and_brand(n: 10, period: Date.yesterday..Date.today, brand_id: 1)
      ServiceUtils.disable_database_logs

      Benchmark.bm do |benchmark|
        benchmark.report('postgresql') do
          n.times do
            Attendance.lost_reasons_count_by(
              filters: {
                start_at: period.first,
                end_at: period.last,
                brand_ids: brand_id
              }
            ).to_a
          end
        end

        benchmark.report('mongodb') do
          n.times do
            Mongo::LostReasons.lost_reasons_count_by(
              filters: {
                date: {
                  '$gte': period.first.to_date,
                  '$lte': period.last.to_date
                },
                brand_id: brand_id
              }
            ).to_a
          end
        end
      end
    end

    def self.by_period(n: 10, period: Date.yesterday..Date.today)
      ServiceUtils.disable_database_logs

      Benchmark.bm do |benchmark|
        benchmark.report('postgresql') do
          n.times do
            Attendance.lost_reasons_count_by(
              filters: {
                start_at: period.first,
                end_at: period.last
              }
            ).to_a
          end
        end

        benchmark.report('mongodb') do
          n.times do
            Mongo::LostReasons.lost_reasons_count_by(
              filters: {
                date: {
                  '$gte': period.first.to_date,
                  '$lte': period.last.to_date
                }
              }
            ).to_a
          end
        end
      end
    end

    def self.by_date(n: 10, date: Date.today)
      ServiceUtils.disable_database_logs

      Benchmark.bm do |benchmark|
        benchmark.report('postgresql') do
          n.times do
            Attendance.lost_reasons_count_by(
              filters: { date: date }
            ).to_a
          end
        end

        benchmark.report('mongodb') do
          n.times do
            Mongo::LostReasons.lost_reasons_count_by(
              filters: { date: date.to_date }
            ).to_a
          end
        end
      end
    end

    def self.all(n: 10)
      ServiceUtils.disable_database_logs

      Benchmark.bm do |benchmark|
        benchmark.report('postgresql') do
          n.times do
            Attendance.lost_reasons_count_by.to_a
          end
        end

        benchmark.report('mongodb') do
          n.times do
            Mongo::LostReasons.lost_reasons_count_by.to_a
          end
        end
      end
    end
  end
end
