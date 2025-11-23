extends XRToolsPickable


var price = 1

func show_price():
	update_info()
	$PriceLabel.show()

func hide_price():
	$PriceLabel.hide()

func update_price():
	price = Globals.INFLATION
	update_info()

func update_info():
	$PriceLabel.text = str((price/Globals.INFLATION)*100) + " %"
	
func _ready() -> void:
	$PriceLabel.hide()
