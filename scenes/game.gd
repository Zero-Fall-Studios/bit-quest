extends Node2D

@export var inventory: Inventory

var block_instance = preload ("res://scenes/environment/block.tscn")
var player_instance = preload ("res://scenes/characters/player.tscn")
var wandering_enemy_instance = preload ("res://scenes/characters/wandering_enemy.tscn")

var player_spawn
var player
var last_location
var block_size = 8
var border_width = 40
var border_height = 21

func _ready():
	border_init()
	player_init()
	enemy_init()
	exit_init()
	inventory_init()
	# if not Globals.has_shown_greeting:
	# 	Globals.has_shown_greeting = true
	# 	Dialogue.show_dialogues([{"text": "Welcome to the game!", "duration": 1}, {"text": "Good luck!", "duration": 1}])

func inventory_init():
	inventory.money_change.connect(_on_money_change)
	
func exit_init():
	var exits = get_tree().get_nodes_in_group("exit")
	for exit in exits:
		exit.exit_entered.connect(_on_exit_entered)

func exit_new_init(way, w, h):
	var random_vec2 = [Vector2(0, 0), Vector2(0, 0), Vector2(0, 0)]
	match way:
		"top":
			var random_width = snapped(randi_range(block_size, (w - 1) * block_size), block_size)
			random_vec2 = [Vector2(random_width - block_size, 0), Vector2(random_width, 0), Vector2(random_width + block_size, 0)]
		"bottom":
			var random_width = snapped(randi_range(block_size, (w - 1) * block_size), block_size)
			random_vec2 = [Vector2(random_width - block_size, h * block_size), Vector2(random_width, h * block_size), Vector2(random_width + block_size, h * block_size)]
		"left":
			var random_height = snapped(randi_range(block_size, (h - 1) * block_size), block_size)
			random_vec2 = [Vector2(0, random_height - block_size), Vector2(0, random_height), Vector2(0, random_height + block_size)]
		"right":
			var random_height = snapped(randi_range(block_size, (h - 1) * block_size), block_size)
			random_vec2 = [Vector2((w - 1) * block_size, random_height - block_size), Vector2((w - 1) * block_size, random_height), Vector2((w - 1) * block_size, random_height + block_size)]
	return random_vec2

func add_block(pos):
	var block = block_instance.instantiate()
	block.position = pos
	add_child(block)

func border_init():

	var random_vec2_list = []

	var way = ["top", "bottom", "left", "right"].pick_random()

	random_vec2_list = exit_new_init(way, border_width, border_height)

	for i in range(0, border_width):

		var top_block = Vector2(i * block_size, 0);
		if not random_vec2_list.has(top_block):
			add_block(top_block)
			
		var bottom_block = Vector2(i * block_size, border_height * block_size)
		if not random_vec2_list.has(bottom_block):
			add_block(bottom_block)

		for j in range(0, border_height):
			var left_block = Vector2(0, j * block_size)
			if not random_vec2_list.has(left_block):
				add_block(left_block)

			var right_block = Vector2((border_width - 1) * block_size, j * block_size)
			if not random_vec2_list.has(right_block):
				add_block(right_block)

func player_init():
	player = player_instance.instantiate()
	player.on_spawn.connect(_on_player_spawn)
	player.on_die.connect(_on_player_die)
	var spawn = get_tree().get_first_node_in_group("player_spawn")
	if spawn:
		player.spawn_position = spawn
	add_child(player)

func enemy_init():
	pass
	#var spawns = get_tree().get_nodes_in_group("enemy_spawn")
	#for spawn in spawns:
		#var enemy = wandering_enemy_instance.instantiate()
		#enemy.spawn_position = spawn
		#add_child(enemy)

func _on_player_spawn(_c, _pos):
  # print("Player spawned", c.name, pos)
	pass

func _on_player_die(c, _pos):
  # print("Player died", c.name, pos)
	c.state_machine.reset()

func _on_exit_entered(_body: Node2D):
	get_tree().reload_current_scene()

func _on_money_change(money):
	print("Money changed to", money)
