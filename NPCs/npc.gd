extends CharacterBody3D

@onready var agent: NavigationAgent3D = $NavigationAgent3D
var speed := 1.2

var target_item: Node3D = null
var drop_position: Vector3
var carrying := false
signal item_checkout(item, npc)

func start_task(item: Node3D, final_pos: Vector3):
	target_item = item
	drop_position = final_pos
	agent.target_position = item.global_transform.origin
	carrying = false


func _physics_process(delta):

	# Si ya está cargando el ítem → ir al punto final
	if carrying:
		
		target_item.global_position = $Hand.global_position
		agent.target_position = drop_position

	# Si terminó la navegación → actuar
	if agent.is_navigation_finished():
		if not carrying and target_item:
			_pick_item()
		elif carrying:
			_drop_item()
		return

	# Movimiento normal hacia el siguiente punto
	var next_pos = agent.get_next_path_position()
	var direction = (next_pos - global_transform.origin).normalized()
	velocity = direction * speed
	
	
	for i in range(get_slide_collision_count()):
		
		var collision = get_slide_collision(i)
		var other = collision.get_collider()
		if other is CharacterBody3D:
			# Detecta si la colisión es frontal
			var normal = collision.get_normal()
				# Empuje lateral
			var side = direction.cross(Vector3.UP)
			velocity += side.normalized() * speed * 20
				# o prueba el otro lado si este no funciona
	move_and_slide()
func _pick_item():
	carrying = true

	# Adjuntar el ítem al NPC
	target_item.get_parent().remove_child(target_item)
	$Hand.add_child(target_item)

	# Opcional: ponerlo en la mano
	target_item.position = Vector3.ZERO
	if target_item is RigidBody3D:
		target_item.freeze = true
	#target_item.process_mode = Node.PROCESS_MODE_DISABLED
	print("Item recogido!")


func _drop_item():
	carrying = false
	var world := get_tree().current_scene
	
	# Sacar el ítem del NPC
	emit_signal("item_checkout", target_item, self)
	remove_child(target_item)
