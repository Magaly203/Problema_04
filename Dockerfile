# Usamos una imagen oficial de Node.js como base para crear nuestro contenedor. 
# Esto es importante porque ya viene con todo lo necesario para ejecutar aplicaciones en Node.js.
FROM node:16

# Aquí definimos el directorio de trabajo dentro del contenedor. 
# Es como crear una carpeta donde vamos a trabajar, en este caso la carpeta será '/usr/src/app'.
WORKDIR /usr/src/app

# Ahora copiamos los archivos 'package.json' y 'package-lock.json' al contenedor.
# Estos archivos contienen las dependencias de la aplicación, así que es importante copiarlos primero
# antes de instalar las dependencias, para no tener que hacerlo nuevamente si no hay cambios en el código.
COPY package*.json ./

# Con esta línea instalamos todas las dependencias de Node.js que nuestra aplicación necesita.
# El comando 'npm install' busca el archivo 'package.json' y descarga las dependencias listadas allí.
RUN npm install

# Luego copiamos todo el código fuente de la aplicación dentro del contenedor.
# Con esto nos aseguramos de que el contenedor tenga acceso a todo el código necesario para ejecutar la aplicación.
COPY . .

# Aquí exponemos el puerto 3000 para que sea accesible fuera del contenedor.
# Es decir, cuando se ejecute el contenedor, podremos acceder a la aplicación a través de este puerto.
# Si nuestra app usa otro puerto, tendríamos que cambiar el número 3000.
EXPOSE 3000

# Finalmente, usamos este comando para ejecutar la aplicación.
# 'npm start' es el comando que normalmente inicia el servidor en aplicaciones Node.js.
# Este comando depende de que esté definido en el archivo 'package.json'.
CMD ["npm", "start"]
