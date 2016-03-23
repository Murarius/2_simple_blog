class CreateAppConfigs < ActiveRecord::Migration
  def change
    create_table :app_configs do |t|
      t.string :sidebar_mark

      t.timestamps null: false
    end
  end
end
