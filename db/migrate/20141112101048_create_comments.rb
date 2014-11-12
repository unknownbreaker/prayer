class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text        :comment
      t.references  :prayerrequest
      t.references  :user

      t.timestamps
    end
  end
end
