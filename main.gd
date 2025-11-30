extends Node3D

var xr_interface: XRInterface

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
	else:
		print("OpenXR not initialized, please check if your headset is connected")
	


func _on_timer_timeout() -> void:
	pick_target($NPC)
	pick_target($NPC2)
	pick_target($NPC3)
	pick_target($NPC4)
	


func _on_npc_item_checkout(item: Variant, npc) -> void:
	Globals.score += int(item.score())
	$Scoring/ScoreLabel.text = str(Globals.score)
	item.queue_free()
	pick_target(npc)
	
func pick_target(npc):
	var product = Globals.productos.pick_random()
	Globals.productos.erase(product)
	npc.start_task(product, $NavigationRegion3D/World/Cashiers/Cashier.position)
	
	


func _on_timer_2_timeout() -> void:
	Globals.INFLATION += 0.01
