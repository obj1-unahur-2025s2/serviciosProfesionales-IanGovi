import profesionalesYEmpresas.*

class Persona {
    const provinciaQueVive

    method puedeSerAtendidoPor(profesional) = profesional.provinciasParaTrabajar().contains(provinciaQueVive)
}

class Institucion {
    const property universidadesReconocidas = #{}
    
    method agregarUniversidad(unaUniversidad) {universidadesReconocidas.add(unaUniversidad)}
    method puedeSerAtendidoPor(profesional) = universidadesReconocidas.contains(profesional.universidad())
}

class Club {
    const provincias = #{}
    
    method agregarSedes(unaProvincia) {provincias.add(unaProvincia)}
    method puedeSerAtendidoPor(profesional) = provincias.any({provincia => profesional.provinciasParaTrabajar().contains(provincia)})
}