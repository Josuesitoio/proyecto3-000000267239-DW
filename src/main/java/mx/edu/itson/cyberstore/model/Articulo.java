package mx.edu.itson.cyberstore.model;

import java.io.Serial;
import java.io.Serializable;

/**
 * POJO / JavaBean que representa un artículo tecnológico de alta gama en el inventario de Cyber-Store.
 */
@SuppressWarnings("unused")
public class Articulo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    private int id;
    private String sku;
    private String nombreProducto;
    private String categoria;
    private double precio;
    private int stock;
    private String fechaRegistro;

    /**
     * Constructor por defecto obligatorio para compatibilidad con JavaBeans y JSTL/EL.
     */
    public Articulo() {
    }

    /**
     * Constructor para la creación de un nuevo artículo antes de su inserción en la base de datos.
     *
     * @param sku            Código de serie / SKU único.
     * @param nombreProducto Nombre comercial del hardware o gadget.
     * @param categoria      Categoría tecnológica.
     * @param precio         Precio unitario.
     * @param stock          Unidades disponibles en bóveda.
     * @param fechaRegistro  Marca temporal de ingreso (yyyy-MM-dd HH:mm).
     */
    public Articulo(String sku, String nombreProducto, String categoria, double precio, int stock, String fechaRegistro) {
        this.sku = sku;
        this.nombreProducto = nombreProducto;
        this.categoria = categoria;
        this.precio = precio;
        this.stock = stock;
        this.fechaRegistro = fechaRegistro;
    }

    /**
     * Constructor completo para la reconstrucción de un artículo desde un ResultSet JDBC.
     *
     * @param id             Identificador único autoincremental.
     * @param sku            Código de serie / SKU único.
     * @param nombreProducto Nombre comercial del hardware o gadget.
     * @param categoria      Categoría tecnológica.
     * @param precio         Precio unitario.
     * @param stock          Unidades disponibles en bóveda.
     * @param fechaRegistro  Marca temporal de ingreso (yyyy-MM-dd HH:mm).
     */
    public Articulo(int id, String sku, String nombreProducto, String categoria, double precio, int stock, String fechaRegistro) {
        this.id = id;
        this.sku = sku;
        this.nombreProducto = nombreProducto;
        this.categoria = categoria;
        this.precio = precio;
        this.stock = stock;
        this.fechaRegistro = fechaRegistro;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(String fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }
}
