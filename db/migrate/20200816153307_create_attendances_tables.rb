class CreateAttendancesTables < ActiveRecord::Migration[6.0]
  def change
    create_table :brands do |t|
      t.string :name, null: false
    end

    create_table :stores do |t|
      t.string :name, null: false
      t.references :brand, null: false, foreign_key: true
    end

    create_table :sellers do |t|
      t.string :name, null: false
      t.references :store, null: false, foreign_key: true
    end

    create_table :products do |t|
      t.string :description, null: false
      t.references :brand, null: false, foreign_key: true
    end

    create_table :lost_reasons, primary_key: :code, id: :string do |t|
      t.string :description, null: false
    end

    create_table :attendance_types, primary_key: :code, id: :string do |t|
      t.string :description, null: false
    end

    create_table :attendances do |t|
      t.references :seller,  null: false, foreign_key: true
      t.references :store,   null: false, foreign_key: true
      t.references :product, foreign_key: true
      t.string :attendance_type_code, null: false
      t.string :lost_reason_code
      t.datetime :start_at, null: false
      t.datetime :end_at,   null: false
      t.timestamps
    end

    add_foreign_key :attendances, :attendance_types, column: :attendance_type_code, primary_key: :code
    add_foreign_key :attendances, :lost_reasons, column: :lost_reason_code, primary_key: :code

    ### movements
    create_table :movement_types, primary_key: :code, id: :string do |t|
      t.string :description, null: false
    end

    create_table :movements do |t|
      t.references :seller, null: false, foreign_key: true
      t.references :store,  null: false, foreign_key: true
      t.string     :movement_type_code, null: false
      t.datetime   :date_time,     null: false
      t.timestamps
    end

    add_foreign_key :movements, :movement_types, column: :movement_type_code, primary_key: :code
  end
end
