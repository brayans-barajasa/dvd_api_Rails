#!/bin/bash

# --- Configuración ---
CONTAINER_NAME="postgres-dvdrental"
BACKUP_FILE="dvdrental.tar"
DB_1="dvdrental"
DB_2="dvdrental_test"
EXTERNAL_PORT="8080"
INTERNAL_PORT="5432"
PG_USER="postgres"
PG_PASSWORD="mysecretpassword" # Puedes cambiar esta contraseña

# --- Lógica del Script ---

# 1. Validar que el archivo de respaldo exista
if [ ! -f "$BACKUP_FILE" ]; then
    echo "❌ Error: No se encontró el archivo '$BACKUP_FILE' en esta carpeta."
    exit 1
fi

echo "🚀 Iniciando la configuración completa en Docker..."

# 2. Detener y eliminar un contenedor antiguo si existe
echo "1/5 - Limpiando contenedores anteriores llamados '$CONTAINER_NAME'..."
docker stop $CONTAINER_NAME > /dev/null 2>&1
docker rm $CONTAINER_NAME > /dev/null 2>&1

# 3. Levantar el nuevo contenedor de PostgreSQL
echo "2/5 - Creando y ejecutando el contenedor de PostgreSQL..."
docker run --name $CONTAINER_NAME \
    -e POSTGRES_PASSWORD=$PG_PASSWORD \
    -p $EXTERNAL_PORT:$INTERNAL_PORT \
    -d postgres

# Esperar un poco para que el servidor de Postgres se inicie completamente
echo "    ...esperando a que el servidor de base de datos esté listo..."
sleep 10

# 4. Copiar el archivo de respaldo al contenedor
echo "3/5 - Copiando '$BACKUP_FILE' al contenedor..."
docker cp $BACKUP_FILE $CONTAINER_NAME:/$BACKUP_FILE

# 5. Bucle para crear y restaurar las bases de datos dentro del contenedor
for DB_NAME in $DB_1 $DB_2
do
    echo "-----------------------------------------------------"
    echo "⚙️  Procesando base de datos: $DB_NAME"
    
    echo "4/5 - Creando la base de datos '$DB_NAME'..."
    docker exec -it $CONTAINER_NAME createdb -U $PG_USER $DB_NAME

    echo "5/5 - Restaurando los datos en '$DB_NAME'..."
    docker exec -it $CONTAINER_NAME pg_restore -U $PG_USER -d $DB_NAME /$BACKUP_FILE
    
    if [ $? -eq 0 ]; then
        echo "✅ ¡Éxito! La base de datos '$DB_NAME' fue creada y cargada."
    else
        echo "❌ ¡Error! Hubo un problema al restaurar '$DB_NAME'."
    fi
done

echo "-----------------------------------------------------"
echo "🎉 ¡Proceso completado!"
echo "Puedes conectarte a tus bases de datos en:"
echo "Host: localhost"
echo "Puerto: $EXTERNAL_PORT"
echo "Usuario: $PG_USER"
echo "Contraseña: $PG_PASSWORD"