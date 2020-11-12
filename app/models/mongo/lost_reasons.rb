class Mongo::LostReasons
  include Mongoid::Document
  include Mongoid::Timestamps

  field :lost_reason_code, type: String
  field :lost_reason_description, type: String
  field :seller_id, type: Integer
  field :seller_name, type: String
  field :store_id, type: Integer
  field :store_name, type: String
  field :brand_id, type: Integer
  field :brand_name, type: String
  field :attendances_count, type: Integer
  field :date, type: Date
end
