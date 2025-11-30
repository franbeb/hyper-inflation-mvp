extends Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# 1. Arrastra aquí tus escenas (enemigos, items, etc.) desde el inspector
@export var objetos_posibles: Array[PackedScene]

# 2. Referencia al nodo padre que contiene los Markers
@export var contenedor_puntos: Node

func _ready():
	# Llamamos a la función al iniciar (o conéctala a una señal/timer)
	spawnear_objetos_random()

func spawnear_objetos_random():
	# Verificamos que existan objetos y puntos para evitar errores
	if objetos_posibles.is_empty() or contenedor_puntos == null:
		print("Error: Faltan asignar objetos o el contenedor de puntos")
		return

	# Obtenemos todos los hijos del contenedor (tus Markers)
	var estanterias = contenedor_puntos.get_children()
	for estante in estanterias:
		var puntos_spawn = estante.get_children()
		
		# 1. Elegimos una escena al azar del array
		var escena_random = objetos_posibles.pick_random()
		# --- OPCIÓN A: Poner un objeto random en CADA punto ---
		for punto in puntos_spawn:
			if punto is Marker3D:
				generar_instancia(punto,escena_random,estante)

	# --- OPCIÓN B: (Alternativa) Elegir SOLO UN punto al azar ---
	# var punto_random = puntos_spawn.pick_random()
	# generar_instancia(punto_random)

func generar_instancia(punto_objetivo,escena_random,estante):
	
	# 2. Instanciamos (creamos) el objeto
	var nuevo_objeto = escena_random.instantiate()
	Globals.productos.append(nuevo_objeto)
	#estante.find_children("AreaGrupo")[0].productos.append(nuevo_objeto) 
	estante.add_child(nuevo_objeto)

	# ESTA es la línea mágica:
	nuevo_objeto.top_level = true 

	nuevo_objeto.global_position = punto_objetivo.global_position
