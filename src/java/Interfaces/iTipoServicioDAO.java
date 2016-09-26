package Interfaces;

import Modelo.TipoServicio;
import java.util.List;

public interface iTipoServicioDAO {
    public int insertar(TipoServicio ts);
    public List<TipoServicio> buscar(String nts);
    public TipoServicio obtenerPorId(int id);
    public int actualizar(TipoServicio ts);
    public int eliminar(int id);
}