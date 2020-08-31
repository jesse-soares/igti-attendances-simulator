# == Schema Information
#
# Table name: brands
#
#  id   :bigint           not null, primary key
#  name :string           not null
#
class Brand < ApplicationRecord
  has_many :stores, inverse_of: :brand, dependent: :destroy
  has_many :products, inverse_of: :brand, dependent: :destroy
end
