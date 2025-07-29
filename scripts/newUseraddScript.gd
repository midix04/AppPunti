extends Node



func _on_add_client_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://addUser.tscn")
	pass


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ListScene.tscn")
	pass


func _on_rapid_search_pressed() -> void:
	get_tree().change_scene_to_file("res://rapidSearch.tscn")
	pass # Replace with function body.
