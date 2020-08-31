# == Schema Information
#
# Table name: movements
#
#  id                 :bigint           not null, primary key
#  date_time          :datetime         not null
#  movement_type_code :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  seller_id          :bigint           not null
#  store_id           :bigint           not null
#
class Movement < ApplicationRecord
  belongs_to :seller
  belongs_to :store
  belongs_to :movement_type, foreign_key: :movement_type_code, primary_key: :code
end
