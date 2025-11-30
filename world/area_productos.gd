extends Area3D

func get_all_products() -> Array:
	var pickable_list = []
	
	# 1. Obtener una referencia al nodo padre.
	var parent_node = get_parent()
	
	# Verificación de seguridad: Asegúrate de que existe un padre.
	if parent_node == null:
		print("Error: El nodo Area no tiene un padre.")
		return pickable_list # Retorna una lista vacía
		
	# 2. Obtenemos todos los hijos directos del nodo PADRE
	# Estos son los hermanos de tu nodo Area.
	var children_of_parent = parent_node.get_children()
	
	# 3. Iteramos sobre cada nodo hijo del padre
	for sibling in children_of_parent:
		# 4. Verificamos si el nodo es del tipo deseado
		if sibling is XRToolsPickable:
			# FILTRO B: Verificamos si ese nodo, además, está en la lista de solapamiento.
			# Solo se añade a la lista si es del tipo correcto Y está dentro del Area3D.
			if get_overlapping_bodies().has(sibling):
				# Si lo es, lo añadimos a nuestra lista
				pickable_list.append(sibling)
			
	return pickable_list
	
func show_price():
	update_info()
	$PriceLabel.show()

func hide_price():
	$PriceLabel.hide()

func update_price():
	var productos = get_all_products()
	for p in productos:
		p.price = Globals.INFLATION
	update_info()
	
func sum(accum, number):
	return accum + number.price
	
func update_info():
	var productos = get_all_products()
	var price = productos.reduce(sum, 0) / productos.size()
	$PriceLabel.text = str(int((price/Globals.INFLATION)*100)) + " %"
	
func _ready() -> void:
	$PriceLabel.hide()
