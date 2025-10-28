import solicitantes.*


class Universidad {
    const property provincia
    const property honorariosPorHoraRecomendado
    var totalRecaudado

    method sumar(unaCantidad) {totalRecaudado += unaCantidad}
}

class ProfesionalVinculado {
    const universidad
    const honorariosPorHoraDeTrabajo = universidad.honorariosPorHoraRecomendado()
    const provinciasParaTrabajar = #{universidad.provincia()}

    method universidad() = universidad
    method honorariosPorHoraDeTrabajo() = honorariosPorHoraDeTrabajo
    method provinciasParaTrabajar() = provinciasParaTrabajar

    //ETAPA 3
    method cobrar(unImporte) {universidad.sumar(unImporte / 2)}
}

class ProfesionalLitoral {
    const universidad
    const honorariosPorHoraDeTrabajo = 3000
    const provinciasParaTrabajar = #{"EntreRios", "SantaFe", "Corrientes"}

    method universidad() = universidad
    method honorariosPorHoraDeTrabajo() = honorariosPorHoraDeTrabajo
    method provinciasParaTrabajar() = provinciasParaTrabajar

    //ETAPA 3
    method cobrar(unImporte) {asociacionDeProfesionalesDelLitoral.sumar(unImporte)}
}

//ETAPA 3
object asociacionDeProfesionalesDelLitoral {
    var totalRecaudado = 0

    method totalRecaudado() = totalRecaudado
    method sumar(cantidad) {totalRecaudado += cantidad}
}

class ProfesionalLibre {
    const universidad
    const honorariosPorHoraDeTrabajo
    const provinciasParaTrabajar
    var totalRecaudado

    method totalRecaudado() = totalRecaudado
    method universidad() = universidad
    method honorariosPorHoraDeTrabajo() = honorariosPorHoraDeTrabajo
    method provinciasParaTrabajar() = provinciasParaTrabajar

    //ETAPA 3
    method cobrar(unImporte) {totalRecaudado += unImporte}
    method pasarDinero(unProfesional, unaCantidad) {
        totalRecaudado -= unaCantidad
        unProfesional.cobrar(unaCantidad)
    }
}

class Empresa {
    const property profesionales = #{}
    const honorarioReferencia
    const property clientes = #{}

    method agregarCliente(unCliente) {clientes.add(unCliente)}
    method agregarProfesional(unProfesional) {profesionales.add(unProfesional)} // SIEMPRE DEBE ESTAR A PESAR DEL PROPERTY
    method cuantosprofEstudiaronEn(unaUniversidad) = profesionales.count({profesional => profesional.universidad() == unaUniversidad})
    method profesionalesCaro() = profesionales.filter({profesional => profesional.honorariosPorHoraDeTrabajo() > honorarioReferencia})
    method universidadesFormadoras() = profesionales.map({profesional => profesional.universidad()}).asSet() // asSet(), no toSet()
    method profesionalMasBarato() = profesionales.min({profesional => profesional.honorariosPorHoraDeTrabajo()})
    method esDeGenteAcotado() = profesionales.all({profesional => profesional.provinciasParaTrabajar().size() <= 3})
    
    //ETAPA 2
    method puedeSatisfacerA(unSolicitante) = profesionales.any({profesional => unSolicitante.puedeSerAtendidoPor(profesional)})
    //SIMPRE QUE "DICE POR, AL MENOS, UNO" SUELE SER UN any()

    //ETAPA 3

    method darServicio(unSolicitante) {
        if(self.puedeSatisfacerA(unSolicitante)) {
            const profesionalElegido = profesionales.filter({ profesional => 
            unSolicitante.puedeSerAtendidoPor(profesional) 
            }).first()
            profesionalElegido.cobrar(profesionalElegido.honorariosPorHoraDeTrabajo())
            self.agregarCliente(unSolicitante)
        }
    }
    method cantidadDeClientes() = clientes.size()
    method tieneComoCliente(unSolicitante) = clientes.contains(unSolicitante)
}