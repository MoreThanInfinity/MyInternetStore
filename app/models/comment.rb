class Comment < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader
  acts_as_votable
  belongs_to :user
  belongs_to :item
end

# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :string
#  user_id    :integer
#  item_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  attachment :string
#
# Indexes
#
#  index_comments_on_item_id  (item_id)
#  index_comments_on_user_id  (user_id)
#
