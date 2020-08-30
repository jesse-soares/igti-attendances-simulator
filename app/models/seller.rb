# == Schema Information
#
# Table name: sellers
#
#  id       :bigint           not null, primary key
#  name     :string           not null
#  store_id :bigint           not null
#
class Seller < ApplicationRecord
  belongs_to :store
end
