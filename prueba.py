from datetime import datetime

# Lista de tickets con prioridad y fecha
lista_tickets = [
    {"id": 1, "prioridad": "Media", "fecha": datetime(2023, 1, 10)},
    {"id": 2, "prioridad": "Alta", "fecha": datetime(2023, 1, 12)},
    {"id": 3, "prioridad": "Alta", "fecha": datetime(2023, 1, 5)},
    {"id": 4, "prioridad": "Baja", "fecha": datetime(2023, 1, 1)},
    {"id": 5, "prioridad": "Alta", "fecha": datetime(2023, 1, 12)},
    {"id": 6, "prioridad": "Media", "fecha": datetime(2023, 1, 10)},
    {"id": 7, "prioridad": "Alta", "fecha": datetime(2023, 1, 20)},
    {"id": 8, "prioridad": "Baja", "fecha": datetime(2023, 1, 1)},
    {"id": 9, "prioridad": "Alta", "fecha": datetime(2023, 1, 5)},
    {"id": 10, "prioridad": "Media", "fecha": datetime(2023, 1, 15)},
]


# Definir el orden de prioridad, de 1 a 3 (1 es la más alta)
orden_prioridad = {"Alta": 1, "Media": 2, "Baja": 3}

# Ordenar tickets por prioridad y fecha
tickets_ordenados = sorted(
    lista_tickets, key=lambda t: (orden_prioridad[t["prioridad"]], t["fecha"])
)

# Mostrar el resultado
for t in tickets_ordenados:
    print(
        f"ID: {t['id']}, Prioridad: {t['prioridad']}, Fecha: {t['fecha'].strftime('%Y-%m-%d')}"
    )
