# 🥗 Food Planner — Aplicación Móvil de Planificación Nutricional

<p align=center>
  <img src=images/logo.png alt=Food Planner Logo width=120 />
</p>

<p align=center>
  <img src=https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white />
  <img src=https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white />
  <img src=https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-green?style=for-the-badge />
  <img src=https://img.shields.io/badge/Storage-SharedPreferences-orange?style=for-the-badge />
  <img src=https://img.shields.io/badge/Architecture-Stateful%20Widgets%20%2B%20Models-purple?style=for-the-badge />
</p>

---

## 📌 Descripción del Proyecto

**Food Planner** es una aplicación móvil desarrollada en **Flutter & Dart** diseñada para simplificar la planificación de comidas, organización de menús semanales y gestión de recetas. La app permite a los usuarios registrar platillos personalizados, clasificarlos por momentos del día, asignar recetas a días específicos de la semana y guardar platillos favoritos, todo con persistencia de datos local rápida y sin necesidad de conexión obligatoria a internet.

---

## ✨ Características Principales

* 🗓️ **Planificador Semanal de Menú:** Asignación dinámica de platillos a los días de la semana (Lunes a Domingo o sin asignar).
* 🍲 **Clasificación por Momentos de Comida:** Categorización intuitiva por Desayuno, Comida, Cena o Snack con iconografía dedicada.
* ⭐ **Gestión de Favoritos:** Marcado rápido de platillos preferidos con filtrado instantáneo en la vista de favoritos.
* 🔍 **Búsqueda y Filtros Reactivos:** Motor de búsqueda por nombre y filtrado cruzado por categoría y día de la semana.
* 💾 **Persistencia de Datos Local:** Almacenamiento seguro en el dispositivo mediante shared_preferences y serialización JSON.
* ⏱️ **Información de Preparación:** Registro de tiempos estimados de cocción en minutos y lista detallada de ingredientes requeridos.
* 🎨 **UI Moderna en Material Design:** Interfaz limpia con estados de carga (CircularProgressIndicator), diálogos modales y animaciones fluidas.

---

## 🏗️ Arquitectura y Estructura del Código

`	ext
lib/
├── data/
│   └── platillos_iniciales.dart      # Mock data y recetas predeterminadas del sistema
├── models/
│   └── platillo.dart                 # Modelo de datos con UUID, Enums y serialización JSON
├── screens/
│   ├── menu_screen.dart              # Pantalla principal con navegación, filtros y búsqueda
│   └── agregar_platillo_screen.dart  # Formulario interactivo para registrar nuevas recetas
├── widgets/
│   └── platillo_item.dart            # Tarjeta reutilizable con acciones (favoritos, eliminar, detalles)
└── main.dart                         # Punto de entrada y configuración de tema global
`

---

## 🛠️ Tecnologías Utilizadas

* **Framework:** [Flutter](https://flutter.dev/) (SDK ^3.11.5)
* **Lenguaje:** [Dart](https://dart.dev/)
* **Librerías principales:**
  * shared_preferences (^2.5.5) — Caché y persistencia de datos local en disco.
  * uuid (^4.6.0) — Generación de identificadores únicos universales (UUID v4) para cada platillo.
  * cupertino_icons (^1.0.8) — Soporte de iconografía estilo iOS/Material.
  * lutter_launcher_icons — Generación automatizada de iconos de la app para Android e iOS.

---

## 🚀 Cómo Ejecutar la Aplicación

### Prerrequisitos
* **Flutter SDK** instalado y configurado en el PATH (lutter doctor).
* Emulador de Android / iOS configurado o dispositivo físico conectado por USB con depuración activada.

### Pasos

1. **Clonar el repositorio:**
   `ash
   git clone https://github.com/Galucio-97/Food-Planner.git
   cd Food-Planner
   `

2. **Instalar dependencias:**
   `ash
   flutter pub get
   `

3. **Ejecutar la app:**
   `ash
   flutter run
   `

---

## 👤 Autor

**Gustavo Aaron Lucio Zubia**  
*Estudiante de Desarrollo de Software Multiplataforma — UTCH*  
* GitHub: [@Galucio-97](https://github.com/Galucio-97)  
* Chihuahua, Chih., México
