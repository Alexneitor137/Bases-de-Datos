import sqlite3
import re

class Colors:
    HEADER = '\033[95m'    # Magenta
    OKBLUE = '\033[94m'    # Blue
    OKCYAN = '\033[96m'    # Cyan
    OKGREEN = '\033[92m'   # Green
    WARNING = '\033[93m'   # Yellow
    FAIL = '\033[91m'      # Red
    ENDC = '\033[0m'       # Reset
    BOLD = '\033[1m'

def is_valid_email(email: str) -> bool:
    pattern = r'^[\w\.-]+@[\w\.-]+\.\w+$'
    return re.match(pattern, email) is not None

def create_table(cursor):
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS clientes (
            identificador INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            apellidos TEXT NOT NULL,
            email TEXT NOT NULL
        )
    """)

def print_header():
    print(f"{Colors.HEADER}{Colors.BOLD}📒 Programa Agenda SQLite v0.5 - Alejandro Calderón Sánchez{Colors.ENDC}")
    print("─" * 60)

def print_menu():
    print(f"\n{Colors.OKCYAN}📋 {Colors.BOLD}Elige una opción:{Colors.ENDC}")
    print(f"{Colors.OKGREEN} 1. 🆕 Crear cliente")
    print( " 2. 📜 Listar clientes")
    print( " 3. ✏️  Actualizar cliente")
    print( " 4. 🗑️  Eliminar cliente")
    print( " 5. 🔍 Buscar cliente")
    print(f" 6. 👋 Cerrar programa{Colors.ENDC}")

def prompt_client_info():
    nombre = input(f"{Colors.WARNING}📝 Introduce el nombre: {Colors.ENDC}").strip()
    apellidos = input(f"{Colors.WARNING}📝 Introduce los apellidos: {Colors.ENDC}").strip()
    email = input(f"{Colors.WARNING}📧 Introduce el email: {Colors.ENDC}").strip()

    if not (nombre and apellidos and email):
        print(f"{Colors.FAIL}❌ Todos los campos son obligatorios.{Colors.ENDC}")
        return None

    if not is_valid_email(email):
        print(f"{Colors.FAIL}🚫 El email no tiene un formato válido.{Colors.ENDC}")
        return None

    return nombre, apellidos, email

def search_clients(cursor):
    print(f"{Colors.OKBLUE}🔍 Buscar cliente{Colors.ENDC}")
    keyword = input(f"{Colors.WARNING}🔎 Introduce nombre, apellidos o email para buscar: {Colors.ENDC}").strip()
    if not keyword:
        print(f"{Colors.FAIL}⚠️ El término de búsqueda no puede estar vacío.{Colors.ENDC}")
        return

    like_term = f"%{keyword}%"
    try:
        cursor.execute("""
            SELECT * FROM clientes
            WHERE nombre LIKE ? COLLATE NOCASE
               OR apellidos LIKE ? COLLATE NOCASE
               OR email LIKE ? COLLATE NOCASE
        """, (like_term, like_term, like_term))
        results = cursor.fetchall()
        if results:
            print(f"{Colors.OKGREEN}✅ Se encontraron {len(results)} resultado(s):{Colors.ENDC}")
            for fila in results:
                print(f"🔹 ID: {fila[0]} | 👤 Nombre: {fila[1]} | 🧑‍🤝‍🧑 Apellidos: {fila[2]} | 📧 Email: {fila[3]}")
        else:
            print(f"{Colors.WARNING}ℹ️ No se encontraron clientes que coincidan con '{keyword}'.{Colors.ENDC}")
    except sqlite3.Error as e:
        print(f"{Colors.FAIL}❌ Error al buscar clientes: {e}{Colors.ENDC}")

def main():
    conexion = sqlite3.connect("empresa.db")
    cursor = conexion.cursor()
    create_table(cursor)

    print_header()

    while True:
        print_menu()

        try:
            opcion = int(input(f"{Colors.WARNING}👉 Selecciona una opción (1-6): {Colors.ENDC}"))
        except ValueError:
            print(f"{Colors.FAIL}❌ Por favor, introduce un número válido.{Colors.ENDC}")
            continue

        if opcion == 1:
            print(f"{Colors.OKBLUE}🆕 Crear nuevo cliente{Colors.ENDC}")
            datos = prompt_client_info()
            if datos is None:
                continue
            nombre, apellidos, email = datos
            try:
                cursor.execute(
                    "INSERT INTO clientes (nombre, apellidos, email) VALUES (?, ?, ?)",
                    (nombre, apellidos, email)
                )
                conexion.commit()
                print(f"{Colors.OKGREEN}🎉 Cliente creado con éxito.{Colors.ENDC}")
            except sqlite3.Error as e:
                print(f"{Colors.FAIL}❌ Error al crear el cliente: {e}{Colors.ENDC}")

        elif opcion == 2:
            print(f"{Colors.OKBLUE}📜 Listado de clientes:{Colors.ENDC}")
            try:
                cursor.execute("SELECT * FROM clientes")
                filas = cursor.fetchall()
                if filas:
                    # Print table header
                    print(f"{Colors.BOLD}{Colors.OKCYAN}")
                    print("┌" + "─" * 5 + "┬" + "─" * 20 + "┬" + "─" * 25 + "┬" + "─" * 30 + "┐")
                    print("│ ID  │ 👤 Nombre           │ 🧑‍🤝‍🧑 Apellidos          │ 📧 Email                     │")
                    print("├" + "─" * 5 + "┼" + "─" * 20 + "┼" + "─" * 25 + "┼" + "─" * 30 + "┤")
                    print(f"{Colors.ENDC}", end="")

                    # Print rows
                    for fila in filas:
                        id_str = str(fila[0]).ljust(4)
                        nombre_str = fila[1][:19].ljust(19)
                        apellidos_str = fila[2][:24].ljust(24)
                        email_str = fila[3][:29].ljust(29)
                        print(f"│ {id_str}│ {nombre_str} │ {apellidos_str} │ {email_str} │")

                    # Table footer
                    print(f"{Colors.BOLD}{Colors.OKCYAN}", end="")
                    print("└" + "─" * 5 + "┴" + "─" * 20 + "┴" + "─" * 25 + "┴" + "─" * 30 + "┘")
                    print(f"{Colors.ENDC}")
                else:
                    print(f"{Colors.WARNING}ℹ️ No hay clientes registrados.{Colors.ENDC}")
            except sqlite3.Error as e:
                print(f"{Colors.FAIL}❌ Error al listar clientes: {e}{Colors.ENDC}")

        elif opcion == 3:
            print(f"{Colors.OKBLUE}✏️ Actualizar cliente{Colors.ENDC}")
            identificador = input(f"{Colors.WARNING}🔢 ID del cliente a actualizar: {Colors.ENDC}").strip()
            if not identificador.isdigit():
                print(f"{Colors.FAIL}❌ El identificador debe ser un número válido.{Colors.ENDC}")
                continue

            datos = prompt_client_info()
            if datos is None:
                continue
            nombre, apellidos, email = datos

            try:
                cursor.execute(
                    """
                    UPDATE clientes 
                    SET nombre = ?, apellidos = ?, email = ?
                    WHERE identificador = ?
                    """,
                    (nombre, apellidos, email, int(identificador))
                )
                conexion.commit()
                if cursor.rowcount > 0:
                    print(f"{Colors.OKGREEN}✅ Cliente actualizado con éxito.{Colors.ENDC}")
                else:
                    print(f"{Colors.WARNING}ℹ️ No se encontró cliente con ese identificador.{Colors.ENDC}")
            except sqlite3.Error as e:
                print(f"{Colors.FAIL}❌ Error al actualizar cliente: {e}{Colors.ENDC}")

        elif opcion == 4:
            print(f"{Colors.OKBLUE}🗑️ Eliminar cliente{Colors.ENDC}")
            identificador = input(f"{Colors.WARNING}🔢 ID del cliente a eliminar: {Colors.ENDC}").strip()
            if not identificador.isdigit():
                print(f"{Colors.FAIL}❌ El identificador debe ser un número válido.{Colors.ENDC}")
                continue

            try:
                cursor.execute(
                    "DELETE FROM clientes WHERE identificador = ?",
                    (int(identificador),)
                )
                conexion.commit()
                if cursor.rowcount > 0:
                    print(f"{Colors.OKGREEN}🗑️ Cliente eliminado con éxito.{Colors.ENDC}")
                else:
                    print(f"{Colors.WARNING}ℹ️ No se encontró cliente con ese identificador.{Colors.ENDC}")
            except sqlite3.Error as e:
                print(f"{Colors.FAIL}❌ Error al eliminar cliente: {e}{Colors.ENDC}")

        elif opcion == 5:
            search_clients(cursor)

        elif opcion == 6:
            print(f"{Colors.HEADER}👋 ¡Hasta luego! Que tengas un gran día.{Colors.ENDC}")
            break

        else:
            print(f"{Colors.FAIL}❌ Opción no válida. Por favor, escoge un número entre 1 y 6.{Colors.ENDC}")

    cursor.close()
    conexion.close()

if __name__ == "__main__":
    main()
