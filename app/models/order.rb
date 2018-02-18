class Order < ApplicationRecord
  belongs_to :user
  has_many :relations
end

# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
