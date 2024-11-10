class CreateJobOffers < ActiveRecord::Migration[7.2]
  def change
    create_table :job_offers do |t|
      t.string :title
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
