class_name Trail
extends Line2D

const MAX_POINTS = 100

@onready var curve := Curve2D.new()

func _ready():
	points.clear()
	curve.clear_points()
	# hide()

func _process(_delta):
	curve.add_point(get_parent().position)
	if curve.get_baked_points().size() > MAX_POINTS:
		curve.remove_point(0)
	points = curve.get_baked_points()

func start():
	points.clear()
	curve.clear_points()
	show()
	var tw := get_tree().create_tween()
	tw.tween_property(self, "modulate:a", 1.0, 0.09)
	await tw.finished

func stop():
	var tw := get_tree().create_tween()
	tw.tween_property(self, "modulate:a", 0.0, 0.09)
	await tw.finished