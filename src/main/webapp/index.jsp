<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:if test="${empty requestScope.catalogoCargado}">
    <c:redirect url="/inventario"/>
</c:if>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NEXUS // CYBER-STORE v4.2 | Inventario de Hardware Cuántico</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;600;700;800&family=Rajdhani:wght@500;600;700&family=Space+Grotesk:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/neofuture.css">
</head>
<body>

<!-- CAPA 1: SECUENCIA DE ARRANQUE INTELIGENTE (QUANTUM CORE BOOTLOADER & NEURAL HANDSHAKE) -->
<div id="boot-preloader" class="preloader-overlay" aria-live="polite">
    <div class="preloader-shutter-top" aria-hidden="true"></div>
    <div class="preloader-shutter-bottom" aria-hidden="true"></div>

    <div class="preloader-terminal">
        <div class="hud-corners" aria-hidden="true">
            <span class="hud-corner-bl"></span>
            <span class="hud-corner-br"></span>
        </div>

        <div class="preloader-header">
            <span>KERNEL // NEXUS-OS v4.2 [SQLITE_EMBEDDED_ENGINE]</span>
            <span id="preloader-chip" class="preloader-status-chip">HANDSHAKE</span>
        </div>

        <div class="preloader-core-stage">
            <div class="quantum-reactor" aria-hidden="true">
                <div class="reactor-ring-outer"></div>
                <div class="reactor-ring-mid"></div>
                <div class="reactor-ring-inner"></div>
                <div class="reactor-core-readout">
                    <span id="preloader-percent" class="preloader-percent">0%</span>
                    <span class="reactor-unit">Q-CORE</span>
                </div>
            </div>

            <div class="preloader-logs">
                <div id="log-stage-1" class="log-line log-active">
                    <span class="log-tag-ok">[OK]</span>
                    <span>MONTANDO BÓVEDA CUÁNTICA (cyberstore.db)...</span>
                </div>
                <div id="log-stage-2" class="log-line">
                    <span class="log-tag-ok">[OK]</span>
                    <span>VERIFICANDO INTEGRIDAD DE PREPARED_STATEMENTS...</span>
                </div>
                <div id="log-stage-3" class="log-line">
                    <span class="log-tag-active">[&gt;&gt;]</span>
                    <span>ESTABLECIENDO ENLACE NEURAL // CARGANDO INVENTARIO...<span class="blink-cursor">&#9611;</span></span>
                </div>
                <div id="log-stage-4" class="log-line">
                    <span class="log-tag-ok">[RDY]</span>
                    <span>MATRIZ HOLOGRÁFICA JSTL 3.0 SINCRONIZADA.</span>
                </div>
            </div>
        </div>

        <div class="preloader-progress-meta">
            <span>SINCRONIZACIÓN DE MATRIZ CUÁNTICA</span>
            <div class="preloader-submetrics">
                <span id="preloader-hex">MEM: 0x00A0</span>
                <span>SQLITE // WAL</span>
            </div>
        </div>
        <div class="preloader-bar-track">
            <div id="preloader-bar-fill" class="preloader-bar-fill"></div>
        </div>
    </div>
</div>

<!-- CAPA 2: FONDO DE ENTORNO VIVO (3D PERSPECTIVE CYBER-GRID + HTML5 CANVAS QUANTUM FIELD) -->
<div class="quantum-environment" aria-hidden="true">
    <div class="cyber-grid-3d"></div>
    <canvas id="quantum-canvas"></canvas>
</div>

<div class="cyber-shell">

    <!-- CABECERA HUD SUPERIOR -->
    <header class="hud-header glass-panel">
        <div class="hud-corners" aria-hidden="true">
            <span class="hud-corner-bl"></span>
            <span class="hud-corner-br"></span>
        </div>

        <div class="hud-brand">
            <span class="hud-eyebrow">
                <span class="hud-eyebrow-dot"></span>
                ENLACE NEURAL ACTIVO // SQLITE EMBEDDED ENGINE
            </span>
            <h1 class="glitch-title" data-text="NEXUS // CYBER-STORE v4.2">NEXUS // CYBER-STORE v4.2</h1>
            <p class="hud-subtitle">SISTEMA DE INVENTARIO Y VENTA DE HARDWARE CUÁNTICO</p>
        </div>

        <div class="hud-telemetry">
            <div class="telemetry-card">
                <span id="telemetry-counter"
                      class="telemetry-count"
                      data-target="<c:out value='${requestScope.totalArticulos}' default='0'/>">
                    <c:out value="${requestScope.totalArticulos}" default="0"/>
                </span>
                <div class="telemetry-meta">
                    <span class="telemetry-tag">TELEMETRÍA EN VIVO</span>
                    <span class="telemetry-label">NODOS DE HARDWARE REGISTRADOS</span>
                </div>
            </div>
        </div>
    </header>

    <!-- BANNERS DE ESTADO POST-REDIRECT-GET (PRG) -->
    <c:if test="${param.status == 'created'}">
        <div class="hud-alert hud-alert-success" role="status">
            <span>// TRANSMISIÓN COMPLETADA: NUEVO ARTÍCULO TECNOLÓGICO SINCRONIZADO EN BÓVEDA SQLITE.</span>
            <span class="alert-tag">STATUS: 201 CREATED</span>
        </div>
    </c:if>

    <c:if test="${param.status == 'error'}">
        <div class="hud-alert hud-alert-error" role="alert">
            <span>// ANOMALÍA DE REGISTRO: VERIFIQUE QUE EL CÓDIGO SKU NO ESTÉ DUPLICADO Y QUE LOS VALORES SEAN VÁLIDOS.</span>
            <span class="alert-tag">ERR: INTEGRITY_CHECK</span>
        </div>
    </c:if>

    <c:if test="${not empty requestScope.dbError}">
        <div class="hud-alert hud-alert-error" role="alert">
            <span>// FALLO DE ENLACE CON NÚCLEO DE DATOS: NO SE PUDO CONSULTAR LA BÓVEDA LOCAL.</span>
            <span class="alert-tag">ERR: DB_LINK</span>
        </div>
    </c:if>

    <!-- MATRIZ PRINCIPAL DE DOS PANELES (CAPA 3 & CAPA 4) -->
    <main class="cyber-grid">

        <!-- PANEL IZQUIERDO: TERMINAL DE INGRESO DE INVENTARIO -->
        <section class="cyber-panel glass-panel panel-ingreso" aria-labelledby="titulo-terminal">
            <div class="hud-corners" aria-hidden="true">
                <span class="hud-corner-bl"></span>
                <span class="hud-corner-br"></span>
            </div>

            <div class="panel-header">
                <div class="panel-title-group">
                    <span class="panel-code">TERMINAL // IN-01</span>
                    <h2 id="titulo-terminal" class="panel-title">Terminal de Ingreso de Inventario</h2>
                </div>
                <span class="panel-badge">PRG // POST</span>
            </div>

            <form class="tactical-form" action="${pageContext.request.contextPath}/inventario" method="post" accept-charset="UTF-8">

                <div class="form-field">
                    <label class="field-label" for="sku">
                        <span>Código de Serie (SKU)</span>
                        <span class="field-hint">Único</span>
                    </label>
                    <input class="cyber-input"
                           type="text"
                           id="sku"
                           name="sku"
                           placeholder="Ej. CYB-NPU-009"
                           pattern="[A-Za-z0-9\-]{3,24}"
                           title="Use letras, números y guiones (3 a 24 caracteres)"
                           required>
                </div>

                <div class="form-field">
                    <label class="field-label" for="nombreProducto">
                        <span>Artículo Tecnológico</span>
                        <span class="field-hint">Denominación</span>
                    </label>
                    <input class="cyber-input"
                           type="text"
                           id="nombreProducto"
                           name="nombreProducto"
                           placeholder="Ej. Coprocesador Sináptico M9"
                           maxlength="120"
                           required>
                </div>

                <div class="form-field">
                    <label class="field-label" for="categoria">
                        <span>Categoría Tecnológica</span>
                        <span class="field-hint">División</span>
                    </label>
                    <select class="cyber-select" id="categoria" name="categoria" required>
                        <option value="Implantes Ópticos">Implantes Ópticos</option>
                        <option value="Procesamiento Cuántico">Procesamiento Cuántico</option>
                        <option value="Almacenamiento Bio-Digital">Almacenamiento Bio-Digital</option>
                        <option value="Redes Neurales">Redes Neurales</option>
                        <option value="Ciberseguridad">Ciberseguridad</option>
                        <option value="Exoesqueletos &amp; Bionics">Exoesqueletos &amp; Bionics</option>
                    </select>
                </div>

                <div class="form-row-2">
                    <div class="form-field">
                        <label class="field-label" for="precio">
                            <span>Precio Unitario</span>
                            <span class="field-hint">Créditos / $</span>
                        </label>
                        <input class="cyber-input"
                               type="number"
                               id="precio"
                               name="precio"
                               step="0.01"
                               min="0"
                               placeholder="0.00"
                               required>
                    </div>

                    <div class="form-field">
                        <label class="field-label" for="stock">
                            <span>Stock en Bóveda</span>
                            <span class="field-hint">Unidades</span>
                        </label>
                        <input class="cyber-input"
                               type="number"
                               id="stock"
                               name="stock"
                               min="0"
                               placeholder="10"
                               required>
                    </div>
                </div>

                <div class="magnetic-wrap">
                    <button type="submit" id="btn-magnetic-submit" class="btn-cyber-submit">
                        + SINCRONIZAR NUEVO HARDWARE
                    </button>
                </div>
            </form>

            <div class="terminal-footnote">
                <span>PROTOCOLO: PREPARED_STATEMENT</span>
                <span>ENC: UTF-8</span>
            </div>
        </section>

        <!-- PANEL DERECHO: CATÁLOGO DE HARDWARE DISPONIBLE -->
        <section class="cyber-panel glass-panel panel-catalogo" aria-labelledby="titulo-catalogo">
            <div class="hud-corners" aria-hidden="true">
                <span class="hud-corner-bl"></span>
                <span class="hud-corner-br"></span>
            </div>

            <div class="panel-header">
                <div class="panel-title-group">
                    <span class="panel-code">MATRIZ // CAT-02</span>
                    <h2 id="titulo-catalogo" class="panel-title">Catálogo de Hardware Disponible</h2>
                </div>
                <span class="panel-badge">JSTL 3.0 // LIVE</span>
            </div>

            <div class="table-scroll-container">
                <c:choose>
                    <c:when test="${not empty requestScope.articulos}">
                        <table class="cyber-table">
                            <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">SKU</th>
                                <th scope="col">ARTÍCULO TECNOLÓGICO</th>
                                <th scope="col">CATEGORÍA</th>
                                <th scope="col">PRECIO UNITARIO</th>
                                <th scope="col">ESTADO DE STOCK</th>
                                <th scope="col">FECHA DE REGISTRO</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${requestScope.articulos}" varStatus="loop">
                                <tr class="cyber-row" style="--row-index: ${loop.index};">
                                    <td class="cell-id">#<c:out value="${item.id}"/></td>
                                    <td>
                                        <span class="cell-sku"><c:out value="${item.sku}"/></span>
                                    </td>
                                    <td class="cell-product">
                                        <c:out value="${item.nombreProducto}"/>
                                    </td>
                                    <td>
                                        <span class="cell-category"><c:out value="${item.categoria}"/></span>
                                    </td>
                                    <td class="cell-price">
                                        <fmt:formatNumber value="${item.precio}"
                                                          type="currency"
                                                          currencySymbol="$"
                                                          minFractionDigits="2"
                                                          maxFractionDigits="2"/>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.stock == 0}">
                                                <span class="stock-badge badge-out">
                                                    <span class="status-dot"></span>
                                                    AGOTADO // 0 UNIDADES
                                                </span>
                                            </c:when>
                                            <c:when test="${item.stock <= 5}">
                                                <span class="stock-badge badge-low">
                                                    <span class="status-dot"></span>
                                                    STOCK CRÍTICO // <c:out value="${item.stock}"/> UNIDADES
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="stock-badge badge-optimal">
                                                    <span class="status-dot"></span>
                                                    ÓPTIMO // <c:out value="${item.stock}"/> UNIDADES
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="cell-date">
                                        <c:out value="${item.fechaRegistro}"/>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-vault">
                            // BÓVEDA CUÁNTICA SIN REGISTROS ACTIVOS. INGRESE UN ARTÍCULO DESDE LA TERMINAL IZQUIERDA.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

    </main>

</div>

<!-- MOTOR DE INTERACTIVIDAD VANILLA JS (CERO SCRIPTLETS) -->
<script>
    (() => {
        "use strict";

        /* ==================================================================
           1. PRELOADER CINEMÁTICO + DIAGNÓSTICO POR ETAPAS + TELEMETRÍA
           ================================================================== */
        const preloader = document.getElementById("boot-preloader");
        const barFill = document.getElementById("preloader-bar-fill");
        const percentText = document.getElementById("preloader-percent");
        const hexText = document.getElementById("preloader-hex");
        const chipText = document.getElementById("preloader-chip");
        const logStage2 = document.getElementById("log-stage-2");
        const logStage3 = document.getElementById("log-stage-3");
        const logStage4 = document.getElementById("log-stage-4");
        const telemetryCounter = document.getElementById("telemetry-counter");

        const isPRG = window.location.search.indexOf("status=") !== -1;
        const bootDuration = isPRG ? 420 : 1850;
        const startTime = performance.now();

        function animateTelemetryCounter() {
            if (!telemetryCounter) return;
            const target = parseInt(telemetryCounter.getAttribute("data-target") || "0", 10);
            if (Number.isNaN(target) || target <= 0) {
                telemetryCounter.textContent = "0";
                return;
            }
            const countStart = performance.now();
            const countDuration = 700;

            function stepCounter(now) {
                const progress = Math.min((now - countStart) / countDuration, 1);
                const eased = 1 - Math.pow(1 - progress, 3);
                telemetryCounter.textContent = String(Math.round(eased * target));
                if (progress < 1) {
                    requestAnimationFrame(stepCounter);
                } else {
                    telemetryCounter.textContent = String(target);
                }
            }

            requestAnimationFrame(stepCounter);
        }

        function updateBootSequence(now) {
            const elapsed = now - startTime;
            const rawRatio = Math.min(elapsed / bootDuration, 1);
            const easedRatio = rawRatio < 0.5
                ? 2 * rawRatio * rawRatio
                : 1 - Math.pow(-2 * rawRatio + 2, 2) / 2;
            const pct = Math.round(easedRatio * 100);

            if (barFill) {
                barFill.setAttribute("style", "width: " + pct + "%;");
            }
            if (percentText) {
                percentText.textContent = pct + "%";
            }
            if (hexText) {
                const hexAddr = (0x7F00 + pct * 37).toString(16).toUpperCase();
                hexText.textContent = "MEM: 0x" + hexAddr;
            }

            if (pct >= 28 && logStage2) {
                logStage2.classList.add("log-active");
            }
            if (pct >= 58 && logStage3) {
                logStage3.classList.add("log-active");
            }
            if (pct >= 88 && logStage4) {
                logStage4.classList.add("log-active");
            }
            if (pct >= 96 && chipText) {
                chipText.textContent = "ONLINE";
            }

            if (rawRatio < 1) {
                requestAnimationFrame(updateBootSequence);
            } else {
                try {
                    sessionStorage.setItem("nexus_booted", "true");
                } catch (err) {
                    // Ignorar si sessionStorage está restringido
                }
                document.body.classList.add("system-ready");
                if (preloader) {
                    preloader.classList.add("preloader-exit");
                }
                animateTelemetryCounter();
            }
        }

        requestAnimationFrame(updateBootSequence);

        /* ==================================================================
           2. BOTÓN MAGNÉTICO CON CÁLCULO DE TRAYECTORIA
           ================================================================== */
        const magneticBtn = document.getElementById("btn-magnetic-submit");
        if (magneticBtn) {
            magneticBtn.addEventListener("mousemove", (evt) => {
                const rect = magneticBtn.getBoundingClientRect();
                const centerX = rect.left + rect.width / 2;
                const centerY = rect.top + rect.height / 2;
                const dx = evt.clientX - centerX;
                const dy = evt.clientY - centerY;
                magneticBtn.setAttribute(
                    "style",
                    "transform: translate3d(" + (dx * 0.18).toFixed(2) + "px, " + (dy * 0.25).toFixed(2) + "px, 0) scale(1.02);"
                );
            });

            magneticBtn.addEventListener("mouseleave", () => {
                magneticBtn.setAttribute("style", "transform: translate3d(0, 0, 0) scale(1);");
            });
        }

        /* ==================================================================
           3. MOTOR DE PARTÍCULAS CUÁNTICAS CON PARALLAX REACTIVO (CANVAS)
           ================================================================== */
        const canvasEl = document.getElementById("quantum-canvas");
        if (!(canvasEl instanceof HTMLCanvasElement)) return;

        const ctx = canvasEl.getContext("2d");
        if (!ctx) return;

        let width = window.innerWidth;
        let height = window.innerHeight;
        canvasEl.width = width;
        canvasEl.height = height;

        const palette = ["#00F0FF", "#7000FF", "#00FF9D"];
        const nodeCount = 45;
        const nodes = [];
        const pointer = { x: width * 0.5, y: height * 0.5, targetX: width * 0.5, targetY: height * 0.5 };

        for (let i = 0; i < nodeCount; i++) {
            nodes.push({
                x: Math.random() * width,
                y: Math.random() * height,
                radius: 1 + Math.random() * 1.5,
                speedY: 0.22 + Math.random() * 0.55,
                speedX: (Math.random() - 0.5) * 0.3,
                color: palette[i % palette.length],
                alpha: 0.35 + Math.random() * 0.55,
                depth: 0.25 + Math.random() * 0.75
            });
        }

        window.addEventListener("resize", () => {
            width = window.innerWidth;
            height = window.innerHeight;
            canvasEl.width = width;
            canvasEl.height = height;
        });

        window.addEventListener("mousemove", (e) => {
            pointer.targetX = e.clientX;
            pointer.targetY = e.clientY;
        });

        function renderQuantumField() {
            ctx.clearRect(0, 0, width, height);

            pointer.x += (pointer.targetX - pointer.x) * 0.05;
            pointer.y += (pointer.targetY - pointer.y) * 0.05;

            const offsetX = (pointer.x - width * 0.5) * 0.025;
            const offsetY = (pointer.y - height * 0.5) * 0.025;

            for (let i = 0; i < nodeCount; i++) {
                const n = nodes[i];
                n.y -= n.speedY;
                n.x += n.speedX;

                if (n.y < -10) {
                    n.y = height + 10;
                    n.x = Math.random() * width;
                }
                if (n.x < -10) n.x = width + 10;
                if (n.x > width + 10) n.x = -10;

                const drawX = n.x + offsetX * n.depth;
                const drawY = n.y + offsetY * n.depth;

                ctx.beginPath();
                ctx.arc(drawX, drawY, n.radius, 0, Math.PI * 2);
                ctx.fillStyle = n.color;
                ctx.globalAlpha = n.alpha;
                ctx.fill();

                for (let j = i + 1; j < nodeCount; j++) {
                    const m = nodes[j];
                    const mDrawX = m.x + offsetX * m.depth;
                    const mDrawY = m.y + offsetY * m.depth;
                    const dx = drawX - mDrawX;
                    const dy = drawY - mDrawY;
                    const dist = Math.sqrt(dx * dx + dy * dy);

                    if (dist < 110) {
                        ctx.beginPath();
                        ctx.moveTo(drawX, drawY);
                        ctx.lineTo(mDrawX, mDrawY);
                        ctx.strokeStyle = "rgba(0, 240, 255, 0.08)";
                        ctx.globalAlpha = 1 - dist / 110;
                        ctx.lineWidth = 0.8;
                        ctx.stroke();
                    }
                }
            }

            ctx.globalAlpha = 1;
            requestAnimationFrame(renderQuantumField);
        }

        requestAnimationFrame(renderQuantumField);
    })();
</script>

</body>
</html>
