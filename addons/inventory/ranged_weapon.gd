extends Weapon
class_name RangedWeapon

@export var fire_rate: float = 0
@export var cooldown_rate: float = 0

@export_subgroup("Charge")
@export var charge_time: float = 0
@export var recharge_time: float = 0
@export var fire_when_charged: bool = false
@export var fire_when_button_released: bool = false

@export_subgroup("Ammo")
@export var clip_amount: int = 0
@export var ammo: int = 0
@export var max_ammo: int = 0
@export var starting_ammo_count: int = 0
@export var recharge_ammo_count: int = 0
@export var unlimited_ammo: bool = false
