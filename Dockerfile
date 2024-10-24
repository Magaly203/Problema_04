# Usamos una imagen oficial de Node.js como base para nuestro contenedor.
# Selecciona una imagen oficial de Node.js en su versión 14 como base para nuestro contenedor.
FROM node:14

# Creamos el directorio de trabajo dentro del contenedor.
# /usr/src/app es donde se ubicará nuestra aplicación.
# Todo lo que copiemos o hagamos desde ahora se ejecutará dentro de esa carpeta, como si fuera el espacio principal donde estará nuestra aplicación.
WORKDIR /usr/src/app

# Copiamos el archivo package.json y package-lock.json para instalar las dependencias.
# Esto asegura que solo se copien los archivos de dependencias y no toda la app.
# Estos archivos son importantes porque contienen las dependencias que la aplicación necesita para funcionar (los paquetes que se instalarán).
COPY package*.json ./

# Ejecutamos el comando npm install para instalar todas las dependencias de la aplicación.
# Esto instala los paquetes necesarios que la aplicación requiere para funcionar.
RUN npm install

# Copiamos el resto del código de la aplicación al contenedor.
# Todo el código fuente de la aplicación es necesario para que funcione.
COPY . .

# Exponemos el puerto 8080 para que la aplicación sea accesible desde el exterior.
# Este es el puerto donde la app correrá.
EXPOSE 8080

# Ejecutamos el comando de inicio de la aplicación.
# CMD ejecuta el comando `npm start` cuando el contenedor se inicia.
# Es el comando principal que pone todo en marcha.
CMD ["npm", "start"]

# En este punto, ya tenemos el entorno de desarrollo para Node.js configurado.
# Ahora, agregamos MySQL al contenedor.

# Primero actualizamos la lista de paquetes con apt-get update.
# Instalamos MySQL Server en el contenedor.
RUN apt-get update && apt-get install -y mysql-server

# Copiamos el archivo de configuración de MySQL al contenedor.
# Este archivo asegura que MySQL esté correctamente configurado.
COPY ./mysql-config.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

# Exponemos el puerto 3306 para MySQL.
# Este es el puerto predeterminado de MySQL.
# Esto permitirá que nuestra base de datos sea accesible desde fuera si lo necesitamos.
EXPOSE 3306

# Iniciamos el servicio de MySQL junto con Node.js.
# El comando CMD asegura que tanto Node.js como MySQL se ejecuten en el mismo contenedor.
CMD ["sh", "-c", "service mysql start && npm start"]
