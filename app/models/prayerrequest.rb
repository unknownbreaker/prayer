class Prayerrequest < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to  :user
  has_many    :favorites, as: :favoriteable
  has_many    :comments
end
