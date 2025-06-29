package com.contacloud.dpinventario.controller;

import com.contacloud.dpinventario.model.MovimientoStock;
import com.contacloud.dpinventario.service.MovimientoStockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/movimientos")
public class MovimientoStockController {

    @Autowired
    private MovimientoStockService movimientoService;

    @PostMapping
    public ResponseEntity<MovimientoStock> registrar(@RequestBody MovimientoStock movimiento) {
        return ResponseEntity.ok(movimientoService.registrarMovimiento(movimiento));
    }

    @GetMapping("/{productoId}")
    public ResponseEntity<List<MovimientoStock>> listarPorProducto(@PathVariable Long productoId) {
        return ResponseEntity.ok(movimientoService.listarPorProducto(productoId));
    }
}
