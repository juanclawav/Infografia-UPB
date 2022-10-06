def promedio_est(estudiante) -> float:
    acum = 0
    for materia, nota in estudiante.items():
        acum+=nota
    
    return acum/len(estudiante)

def promedio_gen(notas, nombres) -> float:
    return sum([promedio_est for nombres, notas in zip(nombres, notas) if (promedio_est(notas)>60)]) / len(notas)

def get_aprobados(notas, nombres):
    aprobados = [promedio_est for nombres, notas in zip(nombres, notas) if (promedio_est(notas)>60)]
    return aprobados
