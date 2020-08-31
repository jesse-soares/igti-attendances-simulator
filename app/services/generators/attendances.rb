module Generators
  class Attendances
    attr_reader :stores, :start_date, :end_date, :monthly_amount

    def initialize(stores: nil, start_date: Date.today, end_date: Date.today, monthly_amount: 10_000_000)
      @start_date = start_date&.to_date
      @end_date   = end_date&.to_date
      @monthly_amount = monthly_amount&.to_i

      validate

      @stores = stores.present? ? Store.where(id: stores) : Store.all
    end

    def generate
      log 'Start...'
      log " - Stores count: #{stores.size}"

      # load models
      lost_reasons = LostReason.all
      attendance_types = AttendanceType.all.map { |a| [a.code.to_sym, a] }.to_h

      (start_date..end_date).each do |date|
        attendances_amount = daily_amount

        log " > date: '#{date}' - generating #{attendances_amount} attendances"

        (0..attendances_amount).each do
          Attendance.create_random stores.sample, date, lost_reasons, attendance_types
        end
      end

      log 'Finish!'
    end

    private

    def validate
      errors = []

      errors << 'Start Date is invalid' if start_date.blank? || !start_date.is_a?(Date)
      errors << 'End Date is invalid' if end_date.present? && !end_date.is_a?(Date)
      errors << 'Monthly Amount is invalid' if monthly_amount.blank? || !monthly_amount.positive?
      errors << 'Start date bigger than End date' if start_date.present? && end_date.present? && start_date > end_date

      throw ArgumentError.new("Ops, errors found: #{errors.join(', ')}") if errors.present?
    end

    def daily_amount
      amount = monthly_amount / 30

      (amount + (amount * rand(-0.15..0.15))).to_i  # amount +- 15%
    end

    def log(text)
      Rails.logger.info "#{text}"
    end
  end
end
