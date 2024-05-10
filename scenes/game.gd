extends Node2D

var exit_instance = preload ("res://scenes/environment/exit.tscn")
var block_instance = preload ("res://scenes/environment/block.tscn")
var player_instance = preload ("res://scenes/characters/player.tscn")
var wandering_enemy_instance = preload ("res://scenes/characters/wandering_enemy.tscn")

var player_spawn
var player
var last_location

func _ready():
  border_init()
  player_init()
  enemy_init()

func exit_last_init(w, h):
  var exit = exit_instance.instantiate()
  exit.exit_entered.connect(_on_exit_entered)
  add_child(exit)

  var way = Globals.last_exit_type
  var last_vec2 = Globals.last_exit_vec2

  match way:
    "top":
      last_vec2 = Vector2(last_vec2.x, h * 16)
      exit.position = Vector2(last_vec2.x, (h + 1) * 16)
      exit.scale.y = -1
    "bottom":
      last_vec2 = Vector2(last_vec2.x, 0)
      exit.position = last_vec2
    "left":
      last_vec2 = Vector2((w - 1) * 16, last_vec2.y)
      exit.position = Vector2(w * 16, last_vec2.y)
      exit.rotation = deg_to_rad(90)
    "right":
      last_vec2 = Vector2(0, last_vec2.y)
      exit.position = Vector2(0, last_vec2.y + 16)
      exit.rotation = deg_to_rad( - 90)
      
  return last_vec2

func exit_new_init(way, w, h):
  var exit = exit_instance.instantiate()
  exit.exit_entered.connect(_on_exit_entered)
  add_child(exit)

  var random_vec2 = Vector2(0, 0)
  match way:
    "top":
      var random_width = snapped(randi_range(16, (w - 1) * 16), 16)
      random_vec2 = Vector2(random_width, 0)
      exit.position = random_vec2
    "bottom":
      var random_width = snapped(randi_range(16, (w - 1) * 16), 16)
      random_vec2 = Vector2(random_width, h * 16)
      exit.position = Vector2(random_width, (h + 1) * 16)
      exit.scale.y = -1
    "left":
      var random_height = snapped(randi_range(16, (h - 1) * 16), 16)
      random_vec2 = Vector2(0, random_height)
      exit.position = Vector2(0, random_height + 16)
      exit.rotation = deg_to_rad( - 90)
    "right":
      var random_height = snapped(randi_range(16, (h - 1) * 16), 16)
      random_vec2 = Vector2((w - 1) * 16, random_height)
      exit.position = Vector2(w * 16, random_height)
      exit.rotation = deg_to_rad(90)

  return random_vec2

func add_block(pos):
  var block = block_instance.instantiate()
  block.position = pos
  add_child(block)

func border_init():

  var width = 20
  var height = 10

  var random_vec2_list = []

  # if Globals.last_exit_type:
  #   last_location = exit_last_init(width, height)
  #   random_vec2_list.append(last_location)

  var way = ["top", "bottom", "left", "right"].pick_random()

  Globals.last_exit_type = way

  var new_location = exit_new_init(way, width, height)

  Globals.last_exit_vec2 = new_location

  random_vec2_list.append(new_location)

  for i in range(0, width):

    var top_block = Vector2(i * 16, 0);
    if not random_vec2_list.has(top_block):
      add_block(top_block)

    var bottom_block = Vector2(i * 16, height * 16)
    if not random_vec2_list.has(bottom_block):
      add_block(bottom_block)

    for j in range(0, height):
      var left_block = Vector2(0, j * 16)
      if not random_vec2_list.has(left_block):
        add_block(left_block)

      var right_block = Vector2((width - 1) * 16, j * 16)
      if not random_vec2_list.has(right_block):
        add_block(right_block)

func player_init():
  player = player_instance.instantiate()
  player.on_spawn.connect(_on_player_spawn)
  player.on_die.connect(_on_player_die)
  add_child(player)

func enemy_init():
  var enemy = wandering_enemy_instance.instantiate()
  add_child(enemy)

func _on_player_spawn(_c, _pos):
  # print("Player spawned", c.name, pos)
  pass

func _on_player_die(c, _pos):
  # print("Player died", c.name, pos)
  c.state_machine.reset()

func _on_exit_entered():
  get_tree().reload_current_scene()