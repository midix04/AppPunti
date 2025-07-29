extends Node

var database : SQLite
func _ready():
	database = SQLite.new()
	database.path = "user://data.db"
	database.open_db()
	var clientsTable = {
		"id": {"data_type":"int", "primary_key": true, "auto_increment": true},
		"name": {"data_type":"text", "not_null":true},
		"cognome":{"data_type":"text", "not_null":true},
		"email":{"data_type":"text"},
		"numTelefono": {"data_type":"int"},
		"soldiSpesi": {"data_type":"int"},
		"punti": {"data_type":"int"}
	}
	database.create_table("clients", clientsTable)
	pass
