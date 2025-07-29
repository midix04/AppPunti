extends Node2D

var database = "user://data.db"

func _on_texture_button_pressed() -> void:
	var database = SQLite.new()
	database.path = "user://data.db"
	database.open_db()

	var data = get_node("TextEdit").text.strip_edges()
	var nome = ""
	var cognome = ""

	if data.find(" ") != -1:
		var parts = data.split(" ", false)  
		nome = parts[0]
		cognome = parts[1] if parts.size() > 1 else ""
		nome = nome[0].to_upper() + nome.substr(1,-1)
		cognome = cognome[0].to_upper() + cognome.substr(1,-1)
		var query = "name = '" + nome + "' AND cognome = '" + cognome + "'"
		var utenti = database.select_rows("clients",query,["id"])
		
		if utenti.size() == 1:
			Global.selected_client_id = utenti[0]["id"]
			get_tree().change_scene_to_file("res://detailedClient.tscn")
		else:
			Global.nomeSearch = nome
			print(Global.nomeSearch)
			get_tree().change_scene_to_file("res://ListScene.tscn")
	else:
		Global.nomeSearch = data
		get_tree().change_scene_to_file("res://ListScene.tscn")
		pass
