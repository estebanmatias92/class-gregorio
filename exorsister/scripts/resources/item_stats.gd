class_name ItemStats
extends Resource

enum Type { ARMA, ARMADURA, ANILLO, CONSUMIBLE, CLAVE }
enum WeaponType { BASICA, MAGICA, MALDITA, SAGRADA }
enum Slot { MANO, CABEZA, PECHERA, DEDO }

@export var item_id: String
@export var display_name: String
@export var item_type: Type
@export var classification: float
@export var weapon_type: WeaponType
@export var slot: Slot
@export var stats: Dictionary = {}
@export var hidden_abilities: Array[String] = []
@export var description: String = ""
@export var buy_price: int = 0
@export var sell_price: int = 0
