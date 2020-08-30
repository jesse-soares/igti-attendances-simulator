# == Schema Information
#
# Table name: movements
#
#  id               :bigint           not null, primary key
#  date_time        :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  movement_type_id :bigint           not null
#  seller_id        :bigint           not null
#  store_id         :bigint           not null
#
class Movement < ApplicationRecord
  belongs_to :movement_type
  belongs_to :seller
  belongs_to :store
end
