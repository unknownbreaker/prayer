class CreatePrayerrequests < ActiveRecord::Migration
  def change
    create_table :prayerrequests do |t|
      t.text        :prayerrequest
      t.references  :user

      t.timestamps
    end
  end
end
