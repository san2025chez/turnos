# Curso de NodeJS con TypeScript y TypeORM

En este curso aprenderas como generar una API REST compleja con NodeJS utilizando como lenguage core `TypeScript` y `TypeORM` como ORM SQL.

## Tecnologias a aplicar:

- POO.
- Docker Compose como base de datos.
- Configuracion de TypeScript.
- Configuracion de rutas, controladores, servicios y entidades.

## Lista de dependencias para instalacion:

Dependencias necesarias:

```
npm install class-validator cors dotenv express morgan mysql typeorm typeorm-naming-strategies typescript
```

Dependencias de desarrollo necesarias:

```
npm install -D @types/cors @types/express @types/morgan concurrently nodemon
```

# Clases:

METODOS:

- <span style="color: #94fc03">PRACTICO</span>
- <span style="color: #03d7fc">TEORICO</span>
- <span style="color: #fc7b03">TEORICO / PRACTICO</span>

| CLASE 1         | Metodo                                                 | Contenido                                    |
| --------------- | ------------------------------------------------------ | -------------------------------------------- |
| **Inicio - P1** | <span style="color: #fc7b03">TEORICO / PRACTICO</span> | Creación de `package.json`                   |
| **Inicio - P1** | <span style="color: #94fc03">PRACTICO</span>           | Instalando dependencias necesarias           |
| **Inicio - P1** | <span style="color: #94fc03">PRACTICO</span>           | Agregando dependencias a utilizar            |
| **Inicio - P1** | <span style="color: #94fc03">PRACTICO</span>           | Configurando `Express`                       |
| **Inicio - P1** | <span style="color: #94fc03">PRACTICO</span>           | Levantando un servidor a traves de una clase |
| **Ruteo - P2**  | <span style="color: #fc7b03">TEORICO / PRACTICO</span> | Aplicar un prefijo global para nuestra API   |
| **Ruteo - P2**  | <span style="color: #94fc03">PRACTICO</span>           | Generando mi primera ruta                    |
| **Ruteo - P2**  | <span style="color: #94fc03">PRACTICO</span>           | Ejecutando lo realizado en Postman           |

| CLASE 2         | Metodo                                                 | Contenido                                                   |
| --------------- | ------------------------------------------------------ | ----------------------------------------------------------- |
| **Ruteo**       | <span style="color: #94fc03">PRACTICO</span>           | Modalidad de ruta para aplicar en un servidor basado en POO |
| **Ruteo**       | <span style="color: #94fc03">PRACTICO</span>           | Generando rutas extendidas de una ruta base                 |
| **Controlador** | <span style="color: #fc7b03">TEORICO / PRACTICO</span> | ¿Que es un controlador? Explicado en ruta                   |

| CLASE 3    | Metodo                                                 | Contenido                                                |
| ---------- | ------------------------------------------------------ | -------------------------------------------------------- |
| **Config** | <span style="color: #94fc03">PRACTICO</span>           | Configuracion de variables de entorno                    |
| **Config** | <span style="color: #fc7b03">TEORICO / PRACTICO</span> | ¿Que es un entorno de ejecucion? Explicado en config     |
| **Config** | <span style="color: #94fc03">PRACTICO</span>           | Declaracion de variables de entorno en nuestro server.ts |

| CLASE 4                 | Metodo                                                 | Contenido                                                 |
| ----------------------- | ------------------------------------------------------ | --------------------------------------------------------- |
| **Docker Compose (DB)** | <span style="color: #94fc03">PRACTICO</span>           | Crear nuestro `docker-compose.yml`                        |
| **Docker Compose (DB)** | <span style="color: #fc7b03">TEORICO / PRACTICO</span> | Ejecutando nuestro docker-compose y comprobar la conexion |
| **TypeORM (DB)**        | <span style="color: #94fc03">PRACTICO</span>           | Crear nuestro getter de configuracion de conexion         |
| **TypeORM (DB)**        | <span style="color: #94fc03">PRACTICO</span>           | Ejecutar la conexion en nuestro server                    |
| **TypeORM (DB)**        | <span style="color: #94fc03">PRACTICO</span>           | Crear nuestra entidad base con datos comunes              |
| **TypeORM (DB)**        | <span style="color: #94fc03">PRACTICO</span>           | Creando nuestra primer entidad para nuestra base de datos |
