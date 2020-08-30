# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :string           not null
#  brand_id    :bigint           not null
#
class Product < ApplicationRecord
  belongs_to :brand
end
