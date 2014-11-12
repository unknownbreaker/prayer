class Comment < ActiveRecord::Base
  # Remember to create a migration!
  validates   :comment, presence: true

  belongs_to  :user
  belongs_to  :prayerrequest
  has_many    :favorites, as: :favoriteable
  has_many    :tags
end
