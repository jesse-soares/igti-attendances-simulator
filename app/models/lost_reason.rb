# == Schema Information
#
# Table name: lost_reasons
#
#  id          :bigint           not null, primary key
#  code        :string           not null
#  description :string           not null
#
class LostReason < ApplicationRecord
end
