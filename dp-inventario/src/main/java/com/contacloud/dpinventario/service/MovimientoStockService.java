package com.contacloud.dpinventario.service;

import com.contacloud.dpinventario.model.MovimientoStock;
import com.contacloud.dpinventario.repository.MovimientoStockRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MovimientoStockService {

    @Autowired
    private MovimientoStockRepository movimientoRepo;

    public MovimientoStock registrarMovimiento(MovimientoStock movimiento) {
        return movimientoRepo.save(movimiento);
    }

    public List<MovimientoStock> listarPorProducto(Long productoId) {
        return movimientoRepo.findByProductoId(productoId);
    }
}
