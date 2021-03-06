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

  def self.lost_reasons_count_by(filters: nil)
    group = {
      '$group': {
        _id: { code: '$lost_reason_code', description: '$lost_reason_description' },
        total: { '$sum': '$attendances_count' }
      }
    }

    filters ? self.collection.aggregate([{ '$match': filters }, group]) : self.collection.aggregate([group])
  end
end
