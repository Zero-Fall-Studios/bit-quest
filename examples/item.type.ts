type ItemType = "MeleeWeapon" | "RangedWeapon" | "Armor" | "Consumable";

type Texture = {
  src: string;
  x: number;
  y: number;
  w: number;
  h: number;
};

type CharacterModifiers = {
  xp?: number;
  hp?: number;
  mp?: number;
  gp?: number;
};

type SkillModifiers = {
  strength?: number;
  dexterity?: number;
  constitution?: number;
  intelligence?: number;
  wisdom?: number;
  charisma?: number;
};

type Armor = {
  armor_class: number;
  weight: number;
  cost: number;
  required_proficiencies?: SkillModifiers[];
  equipable_buffs?: EquipableBuff[];
};

type DamageModifiers = {
  fire?: number;
  acid?: number;
  lightning?: number;
  ice?: number;
};

type MeleeWeapon = {
  damage: number;
};

type RangedWeaponCharge = {
  charged_amount: number;
  duration_until_charged: number;
  recharge_rate: number;
  recharge_amount: number;
  fire_when_charged: boolean;
  fire_when_button_released: boolean;
  cooldown_when_no_charge: number;
  fire_cost: number;
};

type RangedWeaponAmmo = {
  clip_amount: number;
  ammo: number;
};

type RangedWeapon = {
  fire_rate: number;
  charge?: RangedWeaponCharge;
  ammo?: RangedWeaponAmmo;
};

type Weapon = {
  crit_percent: number;
  required_proficiencies?: SkillModifiers[];
  damage_modifiers?: DamageModifiers;
  melee?: MeleeWeapon;
  ranged?: RangedWeapon;
  equipable_buffs?: EquipableBuff[];
};

type ConsumableBuff = {
  duration: number;
  cooldown: number;
  character_modifiers?: CharacterModifiers;
  skill_modifiers?: SkillModifiers;
  damage_modifiers?: DamageModifiers;
};

type Consumable = {
  consume_on_pickup: boolean;
  consumable_buffs?: ConsumableBuff[];
};

type InInventoryBuff = {
  character_modifiers?: CharacterModifiers;
  skill_modifiers?: SkillModifiers;
  damage_modifiers?: DamageModifiers;
};

type EquipableBuff = {
  character_modifiers?: CharacterModifiers;
  skill_modifiers?: SkillModifiers;
  damage_modifiers?: DamageModifiers;
};

type Item = {
  id: string;
  name: string;
  type: ItemType;
  texture: Texture;
  is_unique: boolean;
  stack_amount: number;
  quantity: number;
  in_inventory_buffs?: InInventoryBuff[];
  armor?: Armor;
  weapon?: Weapon;
  consumable?: Consumable;
};

// ARMOR EXAMPLE

const small_silver_shield: Item = {
  id: "abc123",
  name: "Small Silver Shield",
  type: "Armor",
  texture: {
    src: "res://assets/WeaponsAndArmor.png",
    x: 0,
    y: 0,
    w: 16,
    h: 16,
  },
  is_unique: false,
  stack_amount: 1,
  quantity: 1,
  armor: {
    armor_class: 12,
    weight: 1,
    cost: 500,
    required_proficiencies: [{ strength: 12 }],
    equipable_buffs: [
      {
        damage_modifiers: {
          fire: 5,
        },
        skill_modifiers: { dexterity: 5 },
        character_modifiers: {
          hp: 10,
        },
      },
    ],
  },
};

// MELEE WEAPON EXAMPLE

const silver_sword: Item = {
  id: "abc123",
  name: "Silver Sword",
  type: "MeleeWeapon",
  texture: {
    src: "res://assets/WeaponsAndArmor.png",
    x: 0,
    y: 0,
    w: 16,
    h: 16,
  },
  is_unique: false,
  stack_amount: 1,
  quantity: 1,
  weapon: {
    crit_percent: 0.1,
    damage_modifiers: {
      fire: 5,
    },
    melee: {
      damage: 5,
    },
  },
};

const silver_axe: Item = {
  id: "abc1234",
  name: "Silver Axe",
  type: "MeleeWeapon",
  texture: {
    src: "res://assets/WeaponsAndArmor.png",
    x: 16,
    y: 0,
    w: 16,
    h: 16,
  },
  is_unique: false,
  stack_amount: 1,
  quantity: 1,
  weapon: {
    crit_percent: 0.1,
    damage_modifiers: {
      fire: 5,
    },
    melee: {
      damage: 5,
    },
  },
  in_inventory_buffs: [
    {
      damage_modifiers: {
        ice: 5,
      },
      skill_modifiers: {
        strength: 1,
      },
      character_modifiers: {
        hp: 5,
      },
    },
  ],
};

// RANGED WEAPON EXAMPLE

const basic_gun: Item = {
  id: "abc12345",
  name: "Basic Gun",
  type: "RangedWeapon",
  texture: {
    src: "res://assets/WeaponsAndArmor.png",
    x: 16,
    y: 0,
    w: 16,
    h: 16,
  },
  is_unique: false,
  stack_amount: 1,
  quantity: 1,
  weapon: {
    crit_percent: 0.1,
    required_proficiencies: [{ strength: 12 }],
    damage_modifiers: {
      fire: 5,
    },
    ranged: {
      fire_rate: 0.5,
      ammo: {
        clip_amount: 20,
        ammo: 10,
      },
    },
  },
  in_inventory_buffs: [
    {
      damage_modifiers: {
        ice: 5,
      },
      skill_modifiers: {
        strength: 1,
      },
      character_modifiers: {
        hp: 5,
      },
    },
  ],
};

// CHARGEABLE RANGED WEAPON EXAMPLE

const laser: Item = {
  id: "abc12345",
  name: "Laser",
  type: "RangedWeapon",
  texture: {
    src: "res://assets/WeaponsAndArmor.png",
    x: 16,
    y: 0,
    w: 16,
    h: 16,
  },
  is_unique: false,
  stack_amount: 1,
  quantity: 1,
  weapon: {
    crit_percent: 0.1,
    damage_modifiers: {
      fire: 5,
    },
    ranged: {
      fire_rate: 0.5,
      charge: {
        charged_amount: 0,
        duration_until_charged: 2,
        recharge_rate: 10,
        recharge_amount: 1,
        fire_when_charged: false,
        fire_when_button_released: true,
        cooldown_when_no_charge: 10,
        fire_cost: 10,
      },
    },
  },
  in_inventory_buffs: [
    {
      damage_modifiers: {
        ice: 5,
      },
      skill_modifiers: {
        strength: 1,
      },
      character_modifiers: {
        hp: 5,
      },
    },
  ],
};
