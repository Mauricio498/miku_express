# miku_express

## Flujo de pantallas

### Splash Screen
<img width="738" height="1600" alt="image" src="https://github.com/user-attachments/assets/a187d669-74e2-4fb1-8af0-78fa33b007b8" />
### Home Screen
<img width="738" height="1600" alt="image" src="https://github.com/user-attachments/assets/9451dda7-ede5-497e-a7e2-3fb81a8c02c9" />
### Detail Screen
<img width="738" height="1600" alt="image" src="https://github.com/user-attachments/assets/56789cff-1960-4d75-a7bf-c2852972b019" />
### Prueba de interactibilidad
<img width="738" height="1600" alt="image" src="https://github.com/user-attachments/assets/5b27e22b-333a-4e63-8e45-90fefc92a505" />

## Funciones simuladas
- Splash con transición después de 3 segundos.
- Catálogo en cuadrícula.
- Búsqueda por nombre, tienda o categoría.
- Filtros de categoría.
- Favoritos en memoria.
- Detalle de producto, selector de cantidad y confirmación de pedido ficticio.

### Preguntas.

### 1. ¿Qué propiedad de `Scaffold` se utiliza comúnmente para colocar una barra superior con título y botones de acción?

La propiedad es `appBar`. Normalmente se utiliza con un widget `AppBar`, donde se colocan el título de la pantalla y botones o iconos de acción.

### 2. ¿Cuál es el propósito principal de la propiedad `elevation` en el widget `Card` de Flutter?

La propiedad `elevation` controla la elevación visual de la tarjeta y crea una sombra que ayuda a distinguirla del fondo. Un valor mayor suele producir una sombra más marcada.

### 3. ¿Qué widget permite recortar una imagen para que tenga esquinas redondeadas?

Utilizaría `ClipRRect`. Este widget recorta a sus elementos hijos con bordes redondeados. La propiedad `borderRadius` permite definir el radio de las esquinas.

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: Image.asset(
    'assets/images/figura_miku.png',
    fit: BoxFit.cover,
  ),
)
```

### 4. ¿Qué paso previo debes realizar para utilizar imágenes locales con `Image.asset`?

Debes colocar la imagen dentro del proyecto y registrar su ruta en la sección `flutter` del archivo `pubspec.yaml`. También debes comprobar que la ruta y el nombre del archivo coincidan exactamente.

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
```

### 5. ¿Cómo puedes modificar el tamaño y el color de un widget `Icon`?

Se utilizan las propiedades `size` y `color` del widget `Icon`.

```dart
const Icon(
  Icons.favorite,
  size: 32,
  color: Colors.pink,
)
```

### 6. ¿Cuál es la diferencia entre `InkWell` y `GestureDetector`?

`InkWell` detecta interacciones táctiles y, cuando se utiliza dentro de un `Material`, puede mostrar una respuesta visual, como el efecto de onda al tocar. `GestureDetector` detecta gestos, como toques o deslizamientos, pero no proporciona ese efecto visual de forma predeterminada.

### 7. En un widget `Row`, ¿qué propiedad distribuye los widgets hijos a lo largo del eje principal horizontal?

La propiedad es `mainAxisAlignment`. Permite distribuir los elementos al inicio, al centro, al final o con espacios entre ellos, mediante opciones como `spaceBetween`, `spaceAround` y `spaceEvenly`.

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: const [
    Icon(Icons.menu),
    Icon(Icons.shopping_bag),
  ],
)
```

### 8. ¿Qué widget ayuda a evitar un `RenderFlex overflow` cuando un texto largo está dentro de un `Row`?

Puedes envolver el `Text` en un widget `Expanded`. Así, el texto recibe el espacio disponible dentro del `Row`. También puedes establecer `maxLines` y `overflow: TextOverflow.ellipsis` para controlar cómo se muestra si sigue siendo demasiado largo.

```dart
Row(
  children: [
    const Icon(Icons.local_mall),
    const SizedBox(width: 8),
    Expanded(
      child: Text(
        'Nombre muy largo del producto',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ],
)
```

### 9. ¿Cómo puedes enviar datos a una nueva pantalla mediante `Navigator`?

Una forma común es pasar el objeto como argumento del constructor de la pantalla de destino al crear una ruta con `Navigator.push` y `MaterialPageRoute`.

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailScreen(
      producto: producto,
    ),
  ),
);
```

En este ejemplo, `producto` es el objeto que se envía a `DetailScreen`.

### 10. ¿Cómo puedes obtener el resultado que una segunda pantalla devuelve mediante `Navigator.pop(context, resultado)`?

Debes esperar el resultado de `Navigator.push` usando `await`. La ruta devuelve un `Future` que se completa cuando la pantalla se cierra. El valor enviado con `Navigator.pop(context, resultado)` se recibe en la variable asignada al `await`.

```dart
final resultado = await Navigator.push<String>(
  context,
  MaterialPageRoute(
    builder: (context) => const SegundaPantalla(),
  ),
);

if (!context.mounted) return;

if (resultado != null) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Resultado: $resultado')),
  );
}
```

Desde la segunda pantalla, el resultado se devuelve así:

```dart
Navigator.pop(context, 'Pedido confirmado');
```
