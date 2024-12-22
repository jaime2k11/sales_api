# API para ventas ficticias, Versión inicial
Esta es una API para gestionar ventas ficticias, diseñada con **Ruby on Rails**. Incluye autenticación con JWT, control de autenticación y roles, paginación, background jobs, serialización de datos, y reglas de negocio específicas.

---

## Instalación

### Requisitos previos
1. Tener instaladas previamente las siguientes componentes:
   - **Ruby** (versión 3.x o superior)
   - **Rails** (versión 7.x o superior)
   - **PostgreSQL** (con usuario y permisos necesarios para crear y administrar nuevas base de datos)
2. Clonar este repositorio:
   ```bash
   git clone https://github.com/jaime2k11/sales_api.git
   cd sales_api
```

Instalación inicial de dependencias
```bash
bundle install
```

Además de las gemas básicas generadas por el proyecto, se han instalado las siguientes gemas para el desarrollo específico solicitado:

- pundit
- kaminari
- jwt
- bcrypt
- blueprinter
- good_job
- bullet
- letter_opener

Y las siguientes gemas para los ambientes de `development` y `test`

- factory_bot_rails
- faker
- shoulda-matchers
- rspec_rails


Generación y configuración inicial de base de datos

```bash
rails db:create
rails db:migrate
```

Finalmente, iniciar el server localmente
```bash
rails server
```
Con esto, la aplicación estará disponible en la URL `http://localhost:3000`. Se recomienda utilizar herramientas como `Postman` o `curl`, sobre todo para las acciones que requieren el método `POST` para ser llamadas.

## Ejecución de pruebas

Las pruebas se han generado utilizando Rspec como framework principal. Para eso se debe ejecutar el siguiente comando:

```bash
rspec
```

Se han incluido pruebas para los siguientes módulos:

- Controladores: Validación de endpoints y permisos.
- Modelos: Validaciones y relaciones.
- Policies: Reglas de acceso según los roles.
- Background Jobs: Validación de envíos de correo.
- Mailers: Confirmación de contenido y destinatarios.


## Funcionalidades específicas de este proyecto

Las gemas instaladas en este proyecto proveen la implementación limpia y eficiente de las siguientes características

### Autenticación:

Basada en `JWT` y `bcrypt`.
Se provee Middleware para verificar el token enviado en las solicitudes a la API, y establecer el usuario actual para la consulta en curso.

### Paginación:

Se utiliza la gema `Kaminari` para proveer una interfaz simple de consulta paginada de registros hacia la base de datos

### Background Jobs:

Se utiliza la gema `Good Job` para procesos en segundo plano. Por el momento sólo se implementó el envío de correos cuando se crea una venta:
- Al usuario asociado a la venta.
- A los administradores.


### Serialización de Datos:

Uso de `blueprinter` para serializar las respuestas JSON, definiendo de forma clara los campos que cada modelo hace públicos.

### Prevención de Consultas N+1:

Uso de `Bullet` para optimizar las consultas en endpoints como /sales, y notificar de forma personalizada sobre potenciales consultas ineficientes. Por ahora las notificaciones aparecerán en el ambiente de desarrollo, como alertas y logs a nivel de servidor, ya que al ser una API, no es necesario implementar alertas a nivel de navegador web.

## Lógica de Negocio

La forma en que se definió la lógica para este ejemplo ficticio, es la siguiente:

- Se dispone de un módulo de administración de ventas, en que los clientes pueden consultar un catálogo de productos, generar una solicitud de ventas, agregar los productos necesarios, y luego acudir a un vendedor, quien puede hacer modificaciones finales a la venta para luego enviarla a su procesamiento.

- El vendedor puede crear ventas a nombre de un cliente, eliminar órdenes de venta, de ser necesario, y modificar el stock disponible de un producto, bajo condiciones no automáticas (por ejemplo, ante pérdidas de productos por razones externas).

- Se cuenta con el rol de administrador general, quien también puede realizar las acciones de los otros dos roles, pero también posee acceso a la administración general de usuarios y de productos, labores que los otros roles no pueden realizar

## Roles

### Usuario normal (cliente):
- Puede crear una venta.
- Agregar o quitar productos de una venta.


### Usuario vendedor (seller):
- Posee acceso a las mismas acciones de un cliente.
- Puede modificar el estado general de una venta, como cambiar su estado, o el precio final mediante descuentos, promociones, etc.
- Puede eliminar ventas si lo considera necesario.

### Usuario administrador:
- Posee todas las acciones de un seller.
- Puede además crear, editar y eliminar productos.
- Puede administrar usuarios.


## Modelos Principales
### User:

- Atributos: `name`, `email`, `password_digest`, `role`.
- Relación: Tiene muchas sales.

### Sale:

- Atributos: `name`, `total_price`.
- Relación: Pertenece a un User y tiene muchos products a través de sale_products.

### Product:

- Atributos: `name`, `price`, `stock`.
- Relación: Tiene muchas sales a través de sale_products.

### SaleProduct:

- Atributos: `sale_id`, `product_id`, `quantity`.


## Desarrollos pendientes

- Es posible ampliar los tests `Rspec` sobre todas las acciones disponibles de cada controller. Por ejemplo, se pueden crear pruebas para las acciones `update` de los controllers `SalesController` y `ProductsController`

- También faltó ampliar la lógica del controller `ProductsController` y el modelo asociado, para soportar las operaciones de agregar productos a una venta, modificar sus cantidades, quitarlos de la venta, etc.

- Queda pendiente la implementación de estados posibles para una venta, crear la migración apropiada para dicho estado, Agregar una gema para manejo de máquinas de estado, y crear los tests necesarios para esta funcionalidad