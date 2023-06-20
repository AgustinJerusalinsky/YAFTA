# <img class="img-fluid" src="assets/brand/isotype.svg" width="25px" alt="isotype">AFTA

## Yet Another Financial Tracker App

Este proyecto tiene como objetivo ayudar a las personas a realizar un seguimiento de sus movimientos de dinero diariamente además de permitir configurar objetivos y presupuestos mensuales por categorías.

Elegimos desarrollar la aplicación utilizando el framework de [Flutter](https://flutter.dev/). Flutter es un framework de código abierto desarrollado por Google para crear aplicaciones multiplataforma con un mismo código fuente.
Utiliza el lenguaje de programación [Dart](https://dart.dev/) optimizado para el desarrollo de UI.

Si bien Flutter permite crear aplicaciones nativas para Android, iOS, Windows, Mac, Linux y web este proyecto fue desarrollado con el propósito de que sea una aplicación móvil. En el futuro podría considerarse hacer los ajustes necesarios de interfaz y UI para que pueda utilizarse en la web y/o en escritorio.

## Contribuidores

El siguiente proyecto se desarrolló para la materia Desarrollo de Aplicaciones Móviles Multiplataforma del Instituto Tecnológico de Buenos Aires (ITBA) durante el primer cuatrimestre del 2023.

### Autores

- [Francisco Quesada](https://github.com/fquesada00)
- [Agustín Jerusalinsky](https://github.com/AgustinJerusalinsky)
- [Camila Borinsky](https://github.com/camilaborinsky)

## Para correr el proyecto

### Requisitos previos

- [Flutter](https://flutter.dev/docs/get-started/install)

### Pasos

1. Clonar el repositorio
2. Correr `flutter pub get` para instalar las dependencias
3. Correr la aplicación
   - En modo debug: `flutter run`
   - En modo release: `flutter run --release`
   - Para generar el build: `flutter build`

## Documentación

---

### **Requerimientos Funcionales**

A continuación se encuentran los requerimientos funcionales del proyecto.

- Autenticación
  - El usuario debe poder registrarse en la aplicación utilizando su correo electrónico y una contraseña o utilizando su cuenta de Google
  - El usuario debe poder iniciar sesión en la aplicación utilizando su correo electrónico y contraseña o utilizando su cuenta de Google
  - El usuario debe poder cerrar sesión en la aplicación
- Movimientos
  - El usuario debe poder ver una lista de todos sus movimientos
  - El usuario debe poder filtrar los movimientos por categoría
  - El usuario debe poder filtrar los movimientos por fecha
  - El usuario debe poder crear movimientos cargando el motivo, el monto, la categoría y la fecha
  - El usuario debe poder editar los movimientos cargados
  - El usuario debe poder eliminar los movimientos cargados
  - El usuario debe poder ver un resumen de sus movimientos y balance del día, del mes y total.
- Categorías
  - El usuario debe poder ver una lista de todas sus categorías
  - El usuario debe poder crear categorías cargando el nombre, el color y monto máximo
  - El usuario debe poder editar las categorías cargadas
- Perfil
  - El usuario debe poder ver su perfil - El usuario debe poder editar su perfil
    This project is a starting point for a Flutter application.

---

### **Diseño**

En base a los requerimientos funcionales se diseñó la siguiente [interfaz de usuario](https://www.figma.com/file/Kfm8cgmRDOEx6UqzhcqaWd/YAFTA-%7C-DAMM?type=design&node-id=1%3A20&t=scUkePILMglRTDtS-1).
Para la implementación del design system de YAFTA usamos la metodología de [Atomic Design](https://bradfrost.com/blog/post/atomic-web-design/). Dado que en el equipo no contamos con ningún diseñador UX/UI, decidimos utilizar componentes de [Material Design](https://material.io/design). Además la mayoría de los componentes mobile de Material Design ya están [implementados en Flutter](https://docs.flutter.dev/ui/widgets/material).

---

### **Estructura del proyecto**

Para este proyecto decidimos la siguiente estructura de archivos y directorios:

```
├── lib
│   ├── main.dart
│   ├── firebase_options.dart
|   ├── design_system
│   │   ├── tokens
│   │   ├── atoms
│   │   ├── molecules
│   │   └── cells
│   ├── models
│   │   ├── user.dart
│   │   ...
│   ├── routing
│   │   ├── router_provider.dart
│   │   ...
│   ├── screens

```

---

### **Backend**

---

### **State Management**

---

### **Testing**

---

### **Routing**

---

### **Monitoreo**

---

### **Seguridad**

---

### **Feature Flags**
