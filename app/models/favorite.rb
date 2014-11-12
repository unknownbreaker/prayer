class Favorite < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to  :favoriteable, polymorphic: true
  belongs_to  :user
end
