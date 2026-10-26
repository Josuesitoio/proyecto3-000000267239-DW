package mx.edu.itson.cyberstore.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.itson.cyberstore.dao.ArticuloDAO;
import mx.edu.itson.cyberstore.model.Articulo;

import java.io.IOException;
import java.io.Serial;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.List;

/**
 * Controlador MVC principal de Cyber-Store mapeado a la ruta {@code /inventario}.
 * Gestiona la consulta del catálogo vía {@code GET} y el registro de nuevos artículos
 * aplicando el patrón Post-Redirect-Get (PRG) vía {@code POST}.
 */
@WebServlet(name = "TiendaServlet", urlPatterns = {"/inventario"})
public class TiendaServlet extends HttpServlet {

    @Serial
    private static final long serialVersionUID = 1L;
    private static final DateTimeFormatter FORMATO_FECHA = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    private final ArticuloDAO articuloDAO = new ArticuloDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        List<Articulo> listaArticulos;
        try {
            listaArticulos = articuloDAO.listarTodos();
        } catch (SQLException e) {
            listaArticulos = Collections.emptyList();
            request.setAttribute("dbError", true);
        }

        request.setAttribute("articulos", listaArticulos);
        request.setAttribute("totalArticulos", listaArticulos.size());
        request.setAttribute("catalogoCargado", true);

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        request.setCharacterEncoding("UTF-8");

        String sku = limpiarParametro(request.getParameter("sku"));
        String nombreProducto = limpiarParametro(request.getParameter("nombreProducto"));
        String categoria = limpiarParametro(request.getParameter("categoria"));
        String precioStr = limpiarParametro(request.getParameter("precio"));
        String stockStr = limpiarParametro(request.getParameter("stock"));

        if (sku.isEmpty() || nombreProducto.isEmpty() || categoria.isEmpty()
                || precioStr.isEmpty() || stockStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/inventario?status=error");
            return;
        }

        double precio;
        int stock;
        try {
            precio = Double.parseDouble(precioStr);
            stock = Integer.parseInt(stockStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/inventario?status=error");
            return;
        }

        if (precio < 0 || stock < 0) {
            response.sendRedirect(request.getContextPath() + "/inventario?status=error");
            return;
        }

        String fechaRegistro = LocalDateTime.now().format(FORMATO_FECHA);
        Articulo nuevoArticulo = new Articulo(sku, nombreProducto, categoria, precio, stock, fechaRegistro);

        try {
            boolean insertado = articuloDAO.insertar(nuevoArticulo);
            if (insertado) {
                response.sendRedirect(request.getContextPath() + "/inventario?status=created");
            } else {
                response.sendRedirect(request.getContextPath() + "/inventario?status=error");
            }
        } catch (SQLException e) {
            response.sendRedirect(request.getContextPath() + "/inventario?status=error");
        }
    }

    private String limpiarParametro(String valor) {
        return valor == null ? "" : valor.trim();
    }
}
