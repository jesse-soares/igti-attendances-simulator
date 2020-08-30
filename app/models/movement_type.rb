# == Schema Information
#
# Table name: movement_types
#
#  id          :bigint           not null, primary key
#  code        :string           not null
#  description :string           not null
#
class MovementType < ApplicationRecord
end
