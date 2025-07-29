extends Node

var database = "user://data.db"

func _on_texture_button_pressed() -> void:
	database = SQLite.new()
	database.path = "user://data.db"
	database.open_db()
	var nome = get_node("Nome").text
	var cognome = get_node("Cognome").text
	var numero = get_node("Numero").text
	var email = get_node("Email").text
	var soldi = get_node("Soldi").text
	var punti = "0"
	var data = {
		"name" : nome,
		"cognome": cognome,
		"email": email,
		"numTelefono": numero,
		"soldiSpesi": soldi,
		"punti": punti
	}
	database.insert_row("clients", data)
	#get_tree().change_scene_to_file("res://ListScene.tscn")
	


func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
