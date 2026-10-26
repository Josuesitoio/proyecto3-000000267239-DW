package mx.edu.itson.cyberstore.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Gestor de conexiones hacia la base de datos embebida SQLite (cyberstore.db).
 * Garantiza la creación automática del esquema relacional y la carga de datos semilla (seed)
 * en la primera conexión si la tabla se encuentra vacía.
 */
@SuppressWarnings({"SqlNoDataSourceInspection", "SqlDialectInspection"})
public class ConexionBD {

    private static final String URL_BD = "jdbc:sqlite:cyberstore.db";
    private static final String DRIVER_SQLITE = "org.sqlite.JDBC";
    private static volatile boolean inicializado = false;

    private static final String SQL_CREATE_TABLE = """
            CREATE TABLE IF NOT EXISTS articulos (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                sku TEXT NOT NULL UNIQUE,
                nombre_producto TEXT NOT NULL,
                categoria TEXT NOT NULL,
                precio REAL NOT NULL CHECK (precio >= 0),
                stock INTEGER NOT NULL CHECK (stock >= 0),
                fecha_registro TEXT NOT NULL
            );
            """;

    private static final String SQL_COUNT_ARTICULOS = "SELECT COUNT(*) FROM articulos";

    private static final String SQL_INSERT_SEED = """
            INSERT INTO articulos (sku, nombre_producto, categoria, precio, stock, fecha_registro)
            VALUES (?, ?, ?, ?, ?, ?)
            """;

    private ConexionBD() {
        // Clase de utilidad estática
    }

    /**
     * Obtiene una conexión activa a la base de datos SQLite y asegura que la tabla
     * 'articulos' exista y cuente con el seed inicial.
     *
     * @return instancia de {@link Connection} lista para operar.
     * @throws SQLException si ocurre un error al cargar el driver o conectar con SQLite.
     */
    public static Connection obtenerConexion() throws SQLException {
        try {
            Class.forName(DRIVER_SQLITE);
        } catch (ClassNotFoundException e) {
            throw new SQLException("No se encontró el driver JDBC de SQLite: " + DRIVER_SQLITE, e);
        }

        Connection conn = DriverManager.getConnection(URL_BD);
        inicializarBaseDeDatos(conn);
        return conn;
    }

    /**
     * Ejecuta de forma sincronizada el DDL de creación de tabla y el seed inicial
     * de los 3 artículos tecnológicos de alta gama cuando la tabla está vacía.
     *
     * @param conn conexión activa hacia SQLite.
     * @throws SQLException si falla la creación de la tabla o la inserción inicial.
     */
    private static synchronized void inicializarBaseDeDatos(Connection conn) throws SQLException {
        try (Statement stmt = conn.createStatement()) {
            stmt.execute(SQL_CREATE_TABLE);
        }

        if (!inicializado) {
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(SQL_COUNT_ARTICULOS)) {
                if (rs.next() && rs.getInt(1) == 0) {
                    insertarSeedInicial(conn);
                }
                inicializado = true;
            }
        }
    }

    private static void insertarSeedInicial(Connection conn) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(SQL_INSERT_SEED)) {
            // Registro 1
            agregarLoteSeed(ps,
                    "CYB-NV-001",
                    "Neuro-Visor de Realidad Mixta MK-IV",
                    "Implantes Ópticos",
                    18499.99,
                    12,
                    "2026-10-25 18:30");

            // Registro 2 (Stock crítico para demostración en vista)
            agregarLoteSeed(ps,
                    "CYB-GPU-002",
                    "GPU Cuántica RTX-9090 Ti Tensor Core",
                    "Procesamiento Cuántico",
                    42950.00,
                    3,
                    "2026-10-25 19:15");

            // Registro 3
            agregarLoteSeed(ps,
                    "CYB-SSD-003",
                    "Implante de Memoria SSD Neural 16TB",
                    "Almacenamiento Bio-Digital",
                    9750.50,
                    25,
                    "2026-10-25 20:00");

            ps.executeBatch();
        }
    }

    private static void agregarLoteSeed(
            PreparedStatement ps,
            String sku,
            String nombreProducto,
            String categoria,
            double precio,
            int stock,
            String fechaRegistro) throws SQLException {
        ps.setString(1, sku);
        ps.setString(2, nombreProducto);
        ps.setString(3, categoria);
        ps.setDouble(4, precio);
        ps.setInt(5, stock);
        ps.setString(6, fechaRegistro);
        ps.addBatch();
    }
}
