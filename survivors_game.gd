extends Node2D

var gun_number = 1

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio=randf()
	new_mob.global_position=%PathFollow2D.global_position
	add_child(new_mob)

func spawn_tree():
	var new_tree = preload("res://pine_tree.tscn").instantiate()
	%PathFollow2D.progress_ratio=randf()
	new_tree.global_position=%PathFollow2D.global_position
	add_child(new_tree)

func spawn_gun():
	var player = get_node("Player")
	var player_position = Vector2(0, -40)
	match gun_number:
		1:
			player_position = Vector2(40, -120)
		2:
			player_position = Vector2(-40, -120)
		5:
			player_position = Vector2(40, 40)
		4:
			player_position = Vector2(-40, 40)
		3:
			player_position = Vector2(-90, -55)
		_:
			print("Value is something else")
	var new_gun = preload("res://gun.tscn").instantiate()
	new_gun.position=player_position
	player.add_child(new_gun)
	gun_number+=1
	player_position = Vector2(0, -40)

func _on_timer_timeout() -> void:
	spawn_mob()

func _on_player_health_depleted() -> void:
	%GameOver.visible=true
	get_tree().paused=true

func _on_tree_timer_timeout() -> void:
	spawn_tree()

func _on_button_pressed() -> void:
	if gun_number < 6:
		spawn_gun()
