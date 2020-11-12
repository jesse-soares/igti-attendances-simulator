module Generators
  class Utils < ActiveRecord::Migration[6.0]
    # disable fks and indexes to improve performance when generating data
    def disable_fks_indexes
      remove_foreign_key "attendances", "attendance_types", column: "attendance_type_code", primary_key: "code"
      remove_foreign_key "attendances", "lost_reasons", column: "lost_reason_code", primary_key: "code"
      remove_foreign_key "attendances", "products"
      remove_foreign_key "attendances", "sellers"
      remove_foreign_key "attendances", "stores"

      remove_index "attendances", "product_id"
      remove_index "attendances", "seller_id"
      remove_index "attendances", "store_id"
    end

    # re-enable fks and indexes to improve performance when seaching data
    def enable_fks_indexes
      add_foreign_key "attendances", "attendance_types", column: "attendance_type_code", primary_key: "code"
      add_foreign_key "attendances", "lost_reasons", column: "lost_reason_code", primary_key: "code"
      add_foreign_key "attendances", "products"
      add_foreign_key "attendances", "sellers"
      add_foreign_key "attendances", "stores"

      add_index "attendances", "product_id"
      add_index "attendances", "seller_id"
      add_index "attendances", "store_id"
    end
  end
end
