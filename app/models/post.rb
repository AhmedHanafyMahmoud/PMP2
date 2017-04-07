class Post < ApplicationRecord
	mount_uploader :image, ImageUploader
	validates :name, :image, presence: true
	validates :description , length: {maximum: 200}
    belongs_to :user
    has_many :orders, dependent: :destroy
end
