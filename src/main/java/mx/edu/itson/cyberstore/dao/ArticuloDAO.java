package mx.edu.itson.cyberstore.dao;

import mx.edu.itson.cyberstore.config.ConexionBD;
import mx.edu.itson.cyberstore.model.Articulo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Objeto de Acceso a Datos (DAO) para la entidad {@link Articulo}.
 * Emplea exclusivamente {@link PreparedStatement} y bloques try-with-resources
 * para prevenir inyección SQL y bloqueos de archivo en SQLite (database locked).
 */
@SuppressWarnings({"SqlNoDataSourceInspection", "SqlDialectInspection"})
public class ArticuloDAO {

    private static final String SQL_SELECT_ALL = """
            SELECT id, sku, nombre_producto, categoria, precio, stock, fecha_registro
            FROM articulos
            ORDER BY id DESC
            """;

    private static final String SQL_INSERT = """
            INSERT INTO articulos (sku, nombre_producto, categoria, precio, stock, fecha_registro)
            VALUES (?, ?, ?, ?, ?, ?)
            """;

    /**
     * Consulta todos los artículos registrados en la base de datos ordenados del más reciente al más antiguo.
     *
     * @return lista de objetos {@link Articulo}.
     * @throws SQLException si ocurre un error de acceso a la base de datos.
     */
    public List<Articulo> listarTodos() throws SQLException {
        List<Articulo> articulos = new ArrayList<>();

        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(SQL_SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Articulo articulo = new Articulo(
                        rs.getInt("id"),
                        rs.getString("sku"),
                        rs.getString("nombre_producto"),
                        rs.getString("categoria"),
                        rs.getDouble("precio"),
                        rs.getInt("stock"),
                        rs.getString("fecha_registro")
                );
                articulos.add(articulo);
            }
        }

        return articulos;
    }

    /**
     * Inserta un nuevo artículo tecnológico en la base de datos utilizando {@link PreparedStatement}.
     *
     * @param articulo instancia de {@link Articulo} con los datos a registrar.
     * @return {@code true} si se insertó al menos una fila; {@code false} en caso contrario.
     * @throws SQLException si ocurre una violación de restricción (ej. SKU duplicado) o error de conexión.
     */
    public boolean insertar(Articulo articulo) throws SQLException {
        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(SQL_INSERT)) {

            ps.setString(1, articulo.getSku());
            ps.setString(2, articulo.getNombreProducto());
            ps.setString(3, articulo.getCategoria());
            ps.setDouble(4, articulo.getPrecio());
            ps.setInt(5, articulo.getStock());
            ps.setString(6, articulo.getFechaRegistro());

            return ps.executeUpdate() > 0;
        }
    }
}
