
class Empleadoss{
	var salud
	var habilidades= #{}
 	var property puesto = puestoEspia
 	
	method saludCritica()
	
	method incapacitado(){
		return salud <puesto.saludCritica()
	}
	
	method usarHabilidad(habilidad){
		return  not self.incapacitado() && self.tieneHabilidad(habilidad) 
		
	}
	
	method tieneHabilidad(habilidad){
			return habilidades.contains(habilidad)
	}
	
	method recibirDanio(peligrosidad){
		 salud = salud-peligrosidad
	}
	
	method finalizarMision(mision){
		if (salud > 0 ){
			self.completarMision(mision)
		}
	}
	
	method completarMision(mision){
			puesto.completarMision(mision,self)
	}
	
	method aprenderHabilidad(hab){
			habilidades.add(hab)
}
}

class Jefe inherits Empleadoss{
	const subordinados = []
	
	override method tieneHabilidad(habilidad){
			return super(habilidad) || self.algunSubordinadolaTiene(habilidad)
	}

	method algunSubordinadolaTiene(habilidad) = subordinados.any {subordinado => subordinado.tieneHabilidad(habilidad)}
	
}
class Mision{
	var property habilidadesRequeridas = #{}
	const peligrosidad = 0
	
	
	method serCumplidaPor(ente){
	  self.validarHabilidades(ente)	
	  ente.recibirDanio(peligrosidad)
	  ente.finalizarMision(self)
			}
			
	method validarHabilidades(ente){
			if (not self. reuneHabilidadesRequeridas(ente)){
				self.error("La mision no se puede cummplir")
			}
	}
	
	method enseniarHabilidades(empleado){
			self.habilidadesQueNoPosee(empleado)
			.forEach({hab => empleado.aprenderHabilidad(hab)
				})
	}
	
	method reuneHabilidadesRequeridas(ente)=
		habilidadesRequeridas.all({hab => ente.tieneHabilidad(hab)})
		
	method habilidadesQueNoPosee(empleado)=
		habilidadesRequeridas.filter({hab=> not empleado.tieneHabilidad(hab)})
		
}

// PUESTOS

object puestoEspia {
	
		method saludCritica() = 15
		
		method completarMision(mision,empleado){
				mision.enseniarHabilidades(mision, empleado)
		}

}

class PuestoOficinista {
	 var estrellas = 0
		
	 method saludCritica() = 40 - 5 * estrellas	

	method completarMision(mision,empleado){
			estrellas+=1
			if(estrellas == 3){
				empleado.puesto(puestoEspia)
			}
		}
		
		}
//PRUEBA DE CIERRE