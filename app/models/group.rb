class Group < ApplicationRecord
  validates :title, presence: true  # 为何要写在model中：因为model掌管数据库，你做的事情，如果model检查不通过，它就不把数据存到数据库里。你能咋的？
  mount_uploader :image, ImageUploader
end
