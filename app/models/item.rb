class Item < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  acts_as_votable
  has_many :comments, dependent: :destroy
  has_many :relations, dependent: :destroy
  has_many :users, through: :relations
end

# == Schema Information
#
# Table name: items
#
#  id           :integer          not null, primary key
#  availability :boolean
#  name         :string
#  cost         :integer
#  information  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  photo        :string
#
