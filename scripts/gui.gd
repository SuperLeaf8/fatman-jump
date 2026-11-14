extends CanvasLayer

var label: Label
var hudscore: int = 0
func _ready():
	label = get_node("Label")
	label.text = "Score: " + str(hudscore)
	

func _on_player_update_hud(score: Variant) -> void: # recieve the signal
	hudscore += score
	label.text = "Score: " + str(hudscore)
