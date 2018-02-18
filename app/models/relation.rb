class Relation < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :order
end

# == Schema Information
#
# Table name: relations
#
#  id         :integer          not null, primary key
#  message    :string
#  status     :string
#  quantity   :integer
#  user_id    :integer
#  item_id    :integer
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_relations_on_item_id   (item_id)
#  index_relations_on_order_id  (order_id)
#  index_relations_on_user_id   (user_id)
#
