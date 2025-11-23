extends XRToolsPickable


var price = 1

func show_price():
	$PriceLabel.text = str((price/Globals.INFLATION)*100) + " %"
	$PriceLabel.show()

func hide_price():
	$PriceLabel.hide()

func update_price():
	price = Globals.INFLATION
	$PriceLabel.text = str((price/Globals.INFLATION)*100) + " %"
