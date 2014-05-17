class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :subdomain
      t.string :custom_url

      t.timestamps
    end
  end
end
