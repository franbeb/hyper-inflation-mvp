extends XRToolsPickable

func _on_grabbed(pickable: Variant, by: Variant) -> void:
	$LineOfFire.show()


func _on_dropped(pickable: Variant) -> void:
	$LineOfFire.hide()


func _on_action_pressed(pickable: Variant) -> void:
	$HumaParticles.emitting = true
	$AudioStreamPlayer3D.play()
	print(global_rotation)
	print(rotation)
	if $RayCast3D.is_colliding():
		#$RayCast3D.get_collider().apply_central_force(global_position.rotated(Vector3(0,1,0),PI*.75)*100)
		$RayCast3D.get_collider().update_price()

var last_colided = null
func _process(delta: float) -> void:
	if $RayCast3D.is_colliding() and $RayCast3D.get_collider().has_method("show_price"):
		if last_colided != $RayCast3D.get_collider():
			if last_colided:
				last_colided.hide_price()
			last_colided = $RayCast3D.get_collider()
		last_colided = $RayCast3D.get_collider()
		last_colided.show_price()
	elif last_colided:
		last_colided.hide_price()
		last_colided = null
		
		
		
