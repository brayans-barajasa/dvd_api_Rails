class CreateFavoriteFilms < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_films do |t|
      t.references :client, null: false, foreign_key: true
      t.bigint :film_id, null: false
      t.timestamps
    end

    # Añadimos la clave foránea apuntando al nombre correcto de la columna primaria
    add_foreign_key :favorite_films, :film, column: :film_id, primary_key: "film_id"
  end
end
