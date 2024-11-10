class AddDescriptionToApplications < ActiveRecord::Migration[7.2]
  def change
    add_column :applications, :description, :text
  end
end
