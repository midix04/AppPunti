extends Node2D

var database = "user://data.db"
var indice = 0
var arr = []

func _ready():
	database = SQLite.new()
	database.path = "user://data.db"
	database.open_db()
	arr = [
		get_node("nome1"),
		get_node("nome2"),
		get_node("nome3"),
		get_node("nome4"),
		get_node("nome5")
	]
	for label in arr:
		label.bbcode_enabled = true
	mostra_utenti()

func _exit_tree():
	Global.nomeSearch = ""
func mostra_utenti():
	var query = ""
	if Global.nomeSearch != "":
		query = "name LIKE '" +  Global.nomeSearch + "%'"
	var utenti = database.select_rows("clients",query,["id","name","cognome"])
	for i in range(5):
		var index = indice + i
		if index < utenti.size():
			arr[i].text = (
				"[font_size=40]"
				+ str(utenti[index]["id"])
				+ " "
				+ utenti[index]["name"]
				+ " "
				+ utenti[index]["cognome"]
				+ "[/font_size]"
			)
		else:
			arr[i].text = " "

func detailClient(id: String):
	print(id)
	Global.selected_client_id = id
	get_tree().change_scene_to_file("res://detailedClient.tscn")
	


func _on_next_pressed() -> void:
	var utenti = database.select_rows("clients","",["id","name","cognome"])
	if indice + 5 < utenti.size():
		indice += 5
		mostra_utenti()


func _on_prev_pressed() -> void:
	if indice - 5 >= 0:
		indice -= 5
		mostra_utenti()
		
		
func remove_bbcode_tags(text: String) -> String:
	var result = ""
	var inside_tag = false
	for c in text:
		if c == "[":
			inside_tag = true
		elif c == "]":
			inside_tag = false
		elif not inside_tag:
			result += c
	return result.strip_edges()
	
func _on__pressed() -> void:
	var client = get_node("nome1").text
	var clean_text = remove_bbcode_tags(client)  
	var id = clean_text.split(" ")[0]  
	detailClient(id)

func _on__pressed2() -> void:
	var client = get_node("nome2").text
	var clean_text = remove_bbcode_tags(client)  
	var id = clean_text.split(" ")[0]  
	detailClient(id)
func _on__pressed3() -> void:
	var client = get_node("nome3").text
	var clean_text = remove_bbcode_tags(client)  
	var id = clean_text.split(" ")[0]  
	detailClient(id)
func _on__pressed4() -> void:
	var client = get_node("nome4").text
	var clean_text = remove_bbcode_tags(client)  
	var id = clean_text.split(" ")[0]  
	detailClient(id)
func _on__pressed5() -> void:
	var client = get_node("nome5").text
	var clean_text = remove_bbcode_tags(client)  
	var id = clean_text.split(" ")[0]  
	detailClient(id)


func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
