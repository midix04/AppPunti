extends Node2D

var database = "user://data.db"

func _ready() -> void:
	database = SQLite.new()
	database.path = "user://data.db"
	database.open_db()
	print("ID:", Global.selected_client_id)
	var query = "id = " + str(Global.selected_client_id)
	var utenti = database.select_rows("clients",query,["*"])
	print(utenti)
	for utente in utenti:
		var id_utente = str(utente.get("id", "")).strip_edges()
		var id_ricevuto = str(Global.selected_client_id).strip_edges()
		if id_utente == id_ricevuto:
			get_node("nomeCognome2").text = "[font_size=40]" + utente["name"] + " " + utente["cognome"] + "[/font_size]"
			get_node("email").text = "[font_size=40]" + utente["email"] + "[/font_size]"
			get_node("numero").text = "[font_size=40]" + str(utente["numTelefono"]) + "[/font_size]"
			get_node("soldi").text = "[font_size=40]" + str(utente["soldiSpesi"]) + "[/font_size]"
			get_node("punti").text = "[font_size=40]" + str(utente["punti"]) + "[/font_size]"
			break

func _process(delta: float) -> void:
	pass


func _on_list_pressed() -> void:
	get_tree().change_scene_to_file("res://ListScene.tscn")
