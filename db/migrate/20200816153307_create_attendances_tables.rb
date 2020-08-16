class CreateAttendancesTables < ActiveRecord::Migration[6.0]
  def change
    create_table :sellers do |t|
      t.string :name, null: false
    end

    create_table :stores do |t|
      t.string :name, null: false
      t.string :brand, null: false
    end

    create_table :lost_reasons do |t|
      t.string :description, null: false
    end

    create_table :products do |t|
      t.string :description, null: false
    end

    create_table :attendance_types do |t|
      t.string :description, null: false
    end

    create_table :attendances do |t|
      t.references :seller,          null: false, foreign_key: true
      t.references :store,           null: false, foreign_key: true
      t.references :attendance_type, null: false, foreign_key: true
      t.datetime   :start_at, null: false
      t.datetime   :end_at,   null: false
      t.timestamps
    end

    create_table :attendances_lost_reasons, id: false do |t|
      t.references :attendance, null: false, foreign_key: true
      t.references :lost_reason, null: false, foreign_key: true
    end

    create_table :attendances_products, id: false do |t|
      t.references :attendance, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
    end

    ### movements
    create_table :movement_types do |t|
      t.string :description, null: false
    end

    create_table :movements do |t|
      t.references :seller,        null: false, foreign_key: true
      t.references :store,         null: false, foreign_key: true
      t.references :movement_type, null: false, foreign_key: true
      t.datetime   :date_time
      t.timestamps
    end
  end
end
