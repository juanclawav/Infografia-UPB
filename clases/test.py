class Perro:
    def _init_(self, nombre, edad, ladrido):
        self.nombre=nombre
        self.edad=edad
        self.ladrido=ladrido
    def saludo(self):
        print(f"guau, edad {self.edad}")

tilin = Perro("tilin",35,"guau"*5)
tilin.saludo()
