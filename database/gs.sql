CREATE TABLE IF NOT EXISTS LECTURA
(
	LE_COD INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	LE_FECHA TEXT NOT NULL,
	LE_VELOCIDAD REAL NOT NULL,
	LE_DIRECCION REAL NOT NULL,
	LE_TEMPERATURA REAL NOT NULL,
	ES_COD TEXT NOT NULL REFERENCES ESTACION(ES_COD) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS PROVINCIA
(
	PR_COD INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	PR_NOMBRE TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS ESTACION
(
	ES_COD TEXT PRIMARY KEY NOT NULL,
	ES_NOMBRE TEXT NOT NULL,
	ES_UTMX REAL NOT NULL,
	ES_UTMY REAL NOT NULL,
	ES_ALTITUD INTEGER NOT NULL,
	ES_ALTURA_MEDICION REAL,
	PR_COD INTEGER REFERENCES PROVINCIA(PR_COD) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS HORA
(
	HO_COD INTEGER PRIMARY KEY NOT NULL,
	HO_VELOCIDAD_MEDIA REAL NOT NULL,
	HO_DIRECCION_MEDIA REAL NOT NULL,
	HO_VELOCIDAD_MAXIMA REAL NOT NULL,
	HO_VELOCIDAD_MINIMA REAL NOT NULL,
	HO_TEMPERATURA_MAXIMA REAL NOT NULL,
	HO_TEMPERATURA_MEDIA REAL NOT NULL,
	HO_TEMPERATURA_MINIMA REAL NOT NULL,
	HO_FECHA TEXT NOT NULL,
	ES_COD TEXT NOT NULL REFERENCES ESTACION(ES_COD) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS HO_LE
(
	HO_COD INTEGER NOT NULL REFERENCES HORA(HO_COD),
	LE_COD INTEGER NOT NULL REFERENCES ESTACION(ES_COD)
);