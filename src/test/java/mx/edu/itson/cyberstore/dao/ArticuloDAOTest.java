package mx.edu.itson.cyberstore.dao;

import mx.edu.itson.cyberstore.config.ConexionBD;
import mx.edu.itson.cyberstore.model.Articulo;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * Pruebas automatizadas para verificar la auto-inicialización de SQLite (cyberstore.db),
 * la presencia del seed inicial de 3 artículos tecnológicos y las operaciones DAO
 * (SELECT e INSERT con PreparedStatement).
 */
@SuppressWarnings({"SqlNoDataSourceInspection", "SqlDialectInspection"})
class ArticuloDAOTest {

    private static final String SKU_PRUEBA = "CYB-TEST-999";

    @Test
    void debeAutoInicializarBaseDeDatosConSeedYPermitirInsertarYListar() throws SQLException {
        ArticuloDAO dao = new ArticuloDAO();

        // Limpiar registro de prueba previo si existiera de una ejecución anterior
        limpiarRegistroDePrueba();

        // 1. Verificar auto-inicialización y carga del seed inicial (al menos 3 artículos)
        List<Articulo> catalogoInicial = dao.listarTodos();
        assertNotNull(catalogoInicial, "La lista de artículos no debe ser nula");
        assertTrue(catalogoInicial.size() >= 3,
                "La base de datos auto-inicializable debe contener al menos los 3 artículos del seed inicial");

        boolean contieneNeuroVisor = catalogoInicial.stream()
                .anyMatch(a -> "CYB-NV-001".equals(a.getSku()));
        boolean contieneGpuCuantica = catalogoInicial.stream()
                .anyMatch(a -> "CYB-GPU-002".equals(a.getSku()));
        boolean contieneImplanteSsd = catalogoInicial.stream()
                .anyMatch(a -> "CYB-SSD-003".equals(a.getSku()));

        assertTrue(contieneNeuroVisor, "Debe existir el seed CYB-NV-001 (Neuro-Visor de Realidad Mixta MK-IV)");
        assertTrue(contieneGpuCuantica, "Debe existir el seed CYB-GPU-002 (GPU Cuántica RTX-9090 Ti Tensor Core)");
        assertTrue(contieneImplanteSsd, "Debe existir el seed CYB-SSD-003 (Implante de Memoria SSD Neural 16TB)");

        // 2. Verificar inserción con PreparedStatement vía ArticuloDAO
        Articulo nuevoArticulo = new Articulo(
                SKU_PRUEBA,
                "Coprocesador Sináptico Neural M9",
                "Redes Neurales",
                15999.95,
                8,
                "2026-10-25 21:30"
        );

        boolean insertado = dao.insertar(nuevoArticulo);
        assertTrue(insertado, "El método insertar() debe retornar true al registrar un nuevo artículo");

        // 3. Verificar que el artículo recién insertado se recupere en listarTodos()
        List<Articulo> catalogoActualizado = dao.listarTodos();
        assertFalse(catalogoActualizado.isEmpty(), "El catálogo actualizado no debe estar vacío");

        Articulo recuperado = catalogoActualizado.stream()
                .filter(a -> SKU_PRUEBA.equals(a.getSku()))
                .findFirst()
                .orElse(null);

        assertNotNull(recuperado, "El artículo insertado debe encontrarse en la consulta listarTodos()");
        assertTrue(recuperado.getId() > 0, "El artículo recuperado debe tener un ID autogenerado mayor a 0");
        assertEquals("Coprocesador Sináptico Neural M9", recuperado.getNombreProducto());
        assertEquals("Redes Neurales", recuperado.getCategoria());
        assertEquals(15999.95, recuperado.getPrecio(), 0.001);
        assertEquals(8, recuperado.getStock());
        assertEquals("2026-10-25 21:30", recuperado.getFechaRegistro());

        // Limpiar el artículo de prueba para dejar intactos únicamente los datos del seed inicial
        limpiarRegistroDePrueba();
    }

    private void limpiarRegistroDePrueba() throws SQLException {
        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM articulos WHERE sku = ?")) {
            ps.setString(1, SKU_PRUEBA);
            ps.executeUpdate();
        }
    }
}
