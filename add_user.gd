extends Node

var database = "user://data.db"

func _on_texture_button_pressed() -> void:
	database = SQLite.new()
	database.path = "user://data.db"
	database.open_db()
	var flag = false
	var nome = get_node("Nome").text.strip_edges()
	var cognome = get_node("Cognome").text.strip_edges()
	var numero = get_node("Numero").text.strip_edges().replace(" ", "")
	var email = get_node("Email").text.strip_edges()
	var soldi = get_node("Soldi").text.strip_edges()
	var punti = "0"
	if nome.length() > 0:
		nome = nome[0].to_upper() + nome.substr(1,-1)
	else:
		get_node("Nome").placeholder_text = "Name!"
		flag = true
	if cognome.length() > 0:
		cognome = cognome[0].to_upper() + cognome.substr(1,-1)
	else:
		get_node("Cognome").placeholder_text = "Surname!"
		flag = true
	if numero.is_valid_int():  
		var numero2 = numero.to_int()
	else:
		if numero.length()>0:
			get_node("Numero").text = ""
			get_node("Numero").placeholder_text = "Number not valid"
			flag = true
		else:
			numero = "1234123123"
	if soldi.is_valid_int():  
		var soldi2 = soldi.to_int()
	else:
		if soldi.length()>0:
			get_node("Soldi").text = ""
			get_node("Soldi").placeholder_text = "Money not valid"
			flag = true
		else:
			soldi = "0"
	if flag == false:
		var data = {
			"name" : nome,
			"cognome": cognome,
			"email": email,
			"numTelefono": numero,
			"soldiSpesi": soldi,
			"punti": soldi
		}
		database.insert_row("clients", data)
		database.query("SELECT id FROM clients ORDER BY id DESC LIMIT 1")
		
		for i in database.query_result:
			Global.selected_client_id = (i["id"])
		get_tree().change_scene_to_file("res://detailedClient.tscn")
	


func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
