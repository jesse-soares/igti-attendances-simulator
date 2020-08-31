# == Schema Information
#
# Table name: stores
#
#  id       :bigint           not null, primary key
#  name     :string           not null
#  brand_id :bigint           not null
#
class Store < ApplicationRecord
  belongs_to :brand

  has_many :sellers, inverse_of: :store, dependent: :destroy
end
