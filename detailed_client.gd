extends Node2D

var data = []
var database = "user://data.db"

func _ready() -> void:
	database = SQLite.new()
	database.path = "user://data.db"
	database.open_db()
	print("ID:", Global.selected_client_id)
	var query = "id = " + str(Global.selected_client_id)
	var utenti = database.select_rows("clients",query,["*"])
	for utente in utenti:
		data.append(utente)
		var id_utente = str(utente.get("id", "")).strip_edges()
		var id_ricevuto = str(Global.selected_client_id).strip_edges()
		if id_utente == id_ricevuto:
			get_node("nomeCognome2").text = utente["name"] + " " + utente["cognome"]
			get_node("email").text = utente["email"] 
			get_node("numero").text = str(utente["numTelefono"])
			get_node("soldi").text =  str(utente["soldiSpesi"])
			get_node("punti").text = str(utente["punti"])
			break

func _process(delta: float) -> void:
	pass

func _exit_tree():
	var nomeCognome = get_node("nomeCognome2").text
	var parts = nomeCognome.split(" ")
	var nome = parts[0]
	var cognome = parts[1]
	var id = Global.selected_client_id
	var soldi = get_node("soldi").text
	var numeroTel = get_node("numero").text
	var punti = get_node("punti").text
	var email = get_node("email").text
	var newData = [nome, cognome,email,numeroTel,soldi,punti]
	var oldData = data[0]  
	var oldValues = [
		oldData.name,
		oldData.cognome,
		oldData.email,
		oldData.numTelefono,
		oldData.soldiSpesi,
		str(oldData.punti)  
		]
	for i in range(oldValues.size()):
		if str(newData[i]) != str(oldValues[i]):
			updateData(newData)

func updateData(data):
	database.update_rows("clients", "id='"+str(Global.selected_client_id)+"'", {"name":data[0], "cognome":data[1], "email":data[2], "numTelefono":data[3],"soldiSpesi":data[4],"punti":data[5]})
	print(data)
func _on_list_pressed() -> void:
	get_tree().change_scene_to_file("res://ListScene.tscn")


func _on_delete_btn_pressed() -> void:
	var id = Global.selected_client_id
	database.delete_rows("clients", "id= '" + id + "'")
	get_tree().change_scene_to_file("res://main.tscn")
	pass
