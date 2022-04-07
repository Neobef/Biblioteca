CREATE DATABASE biblioteca;

CREATE TABLE socios(
    rut VARCHAR (15),
    nombre VARCHAR (25),
    apellido VARCHAR (25),
    direccion VARCHAR (50),
    telefono VARCHAR (25),
    PRIMARY KEY (rut)
);

CREATE TABLE libros(
    isbn VARCHAR (25),
    titulo VARCHAR(25),
    paginas SMALLINT,
    PRIMARY KEY (isbn)
);

CREATE TABLE autores(
    id VARCHAR (15),
    nombre_autor VARCHAR (25),
    apellido_autor VARCHAR (25),
    ano_nacimiento SMALLINT null,
    ano_muerte SMALLINT null,
    PRIMARY KEY (id)
);

CREATE TABLE participantes_libro(
    id SERIAL,
    isbn_libro VARCHAR (25),
    cod_autor VARCHAR (15),
    es_autor_principal BOOLEAN,
    PRIMARY KEY (id) FOREIGN KEY (isbn_libro) REFERENCES libros(ISBN),
    FOREIGN KEY (cod_autor) REFERENCES autor (id)
);

CREATE TABLE historial_de_prestamos(
    id SERIAL,
    isbn_libro VARCHAR (25),
    rut_socio VARCHAR (15),
    fecha_inicio DATE,
    fecha_estimada_devolucion DATE,
    fecha_real_devolucion DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (rut_socio) REFERENCES socio (rut),
    FOREIGN KEY (isbn_libro) REFERENCES libro (isbn)
);

INSERT INTO
    public.socios(rut, nombre, apellido, direccion, telefono)
VALUES
    (
        "1111111-1",
        "JUAN",
        "SOTO",
        "AVENIDA 1, SANTIAGO",
        "911111111"
    ),
    (
        "2222222-2",
        "ANA",
        "PÉREZ",
        "PASAJE 2, SANTIAGO",
        "922222222"
    ),
    (
        "3333333-3",
        "SANDRA",
        "AGUILAR",
        "AVENIDA 2, SANTIAGO",
        "933333333"
    ) (
        "4444444-4",
        "ESTEBAN",
        "JEREZ",
        "AVENIDA 3, SANTIAGO",
        "944444444"
    ) (
        "5555555-5",
        "SILVANA",
        "MUÑOZ",
        "PASAJE 3, SANTIAGO",
        "955555555"
    );

INSERT INTO
    public.libros (isbn, titulo, paginas)
VALUES
    ('111-1111111-111', 'CUENTOS DE TERROR', 344),
    ('222-2222222-222', 'POESÍAS CONTEMPORANEAS', 167),
    ('333-3333333-333', 'HISTORIA DE ASIA', 511),
    ('444-4444444-444', 'MANUAL DE MECÁNICA', 298);

INSERT INTO
    public.participantes_libro(ISBN, codigo_autor, tipo_autor)
values
    ('111-1111111-111', 3, true),
    ('111-1111111-111', 4, false),
    ('222-2222222-222', 1, true),
    ('333-3333333-333', 2, true),
    ('444-4444444-444', 5, true);

INSERT INTO
    public.autores (
        id,
        nombre_autor,
        apellido_autor,
        ano_nacimiento,
        ano_muerte
    )
values
    (1, 'ANDRES', 'ULLOA', 1982, null),
    (2, 'SERGIO', 'MARDONES', 1950, 2012),
    (3, 'JOSE', 'SALGADO', 1968, 2020),
    (4, 'ANA', 'SALGADO', 1972, null),
    (5, 'MARTIN', 'PORTA', 1976, null);

INSERT INTO
    public.historial_de_prestamos(
        isbn_libro,
        rut_socio,
        fecha_prestamo,
        fecha_estimada_devolucion,
        fecha_real_devolucion
    )
VALUES
    (
        "111-1111111-111",
        "1111111-1",
        "2020-01-20",
        null,
        "2020-01-27"
    ),
    (
        "222-2222222-222",
        "5555555-5",
        "2020-01-20",
        null,
        "2020-01-30"
    ),
    (
        "333-3333333-333",
        "3333333-3",
        "2020-01-22",
        null,
        "2020-01-30"
    ),
    (
        "444-4444444-444",
        "4444444-4",
        "2020-01-23",
        null,
        "2020-01-30"
    ),
    (
        "111-1111111-111",
        "2222222-2",
        "2020-01-27",
        null,
        "2020-02-04"
    ),
    (
        "444-4444444-444",
        "1111111-1",
        "2020-01-31",
        null,
        "2020-02-12"
    ),
    (
        "222-2222222-222",
        "3333333-3",
        "2020-01-31",
        null,
        "2020-02-12"
    );

A.-
SELECT
    titulo,
    paginas
FROM
    libros
WHERE
    paginas < 300;

B.-
SELECT
    *
FROM
    autores
WHERE
    ano_nacimiento >= 1970;

C.-
SELECT
    count(p.isbn_libro),
    l.titulo
FROM
    historial_de_prestamos p
    INNER JOIN libros l ON p.isbn_libro = l.isbn
GROUP BY
    l.titulo
ORDER BY
    count(p.isbn_libro) desc,
    l.titulo
LIMIT
    1;

D.-
SELECT
    100 * (fecha_real_devolucion - fecha_prestamo) AS multa,
    CONCAT(nombre, ' ', apellido),
    fecha_prestamo,
    fecha_real_devolucion
FROM
    historial_de_prestamos
    INNER JOIN socios ON rut_socio = rut
WHERE
    (fecha_real_devolucion - fecha_prestamo) > 7
GROUP BY
    id,
    CONCAT(nombre, ' ', apellido);
