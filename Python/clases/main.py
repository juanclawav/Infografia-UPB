from utils import promedio_est, promedio_gen, get_aprobados

estudiante ={
    "mat": 90,
    "fis": 69,
    "qmc": 20,
    "cal": 15
}

print(promedio_est(estudiante))

notas = [{"mat": 90,"fis": 69,"qmc": 80,"cal": 85},{"mat": 0,"fis": 9,"qmc": 0,"cal": 5},
        {"mat": 90,"fis": 69,"qmc": 20,"cal": 15},{"mat": 90,"fis": 69,"qmc": 20,"cal": 15},
        {"mat": 90,"fis": 69,"qmc": 20,"cal": 15},{"mat": 90,"fis": 69,"qmc": 20,"cal": 15
        }]

nombres = ["juancho","juancho","juancho","juancho","juancho","juancho",]

print(promedio_gen(notas, nombres))