import json
from os import path
from pathlib import Path

script = Path(__file__)
name, ext = path.splitext(path.basename(script))

ltos_dir = script.parents[1].absolute()
loot_tables_dir = path.join(ltos_dir, "no_item_output_alternatives")


def patch_blocks(base):
    structure = {
        "type": "minecraft:block",
        "pools": [
            {
                "rolls": 1,
                "entries": [
                    {
                        "type": "minecraft:loot_table",
                        "value": "ltos:data",
                        "functions": [
                            {
                                "function": "minecraft:set_custom_data",
                                "tag": "{block:'" + base + "'}"
                            }
                        ]
                    }
                ]
            }
        ],
        "random_sequence": "minecraft:blocks/" + base
    }

    return structure


def patch_entities(base):
    structure = {
        "type": "minecraft:entity",
        "pools": [
            {
                "rolls": 1,
                "entries": [
                    {
                        "type": "minecraft:loot_table",
                        "value": "ltos:entity_data",
                        "functions": [
                            {
                                "function": "minecraft:set_custom_data",
                                "tag": "{entity:'" + base + "'}"
                            }
                        ]
                    }
                ]
            }
        ],
        "random_sequence": "minecraft:entities/" + base
    }

    return structure


for loot_table in Path(path.join(loot_tables_dir, "blocks")).glob("*.json"):
    with open(loot_table, "r+") as loaded_loot_table:
        base_block = path.splitext(path.basename(loot_table))[0]
        current_loot_table = patch_blocks(base_block)

        loaded_loot_table.seek(0)

        json.dump(current_loot_table, loaded_loot_table, indent=4)
        loaded_loot_table.truncate()

for loot_table in Path(path.join(loot_tables_dir, "entities")).glob("*.json"):
    with open(loot_table, "r+") as loaded_loot_table:
        base_entity = path.splitext(path.basename(loot_table))[0]
        current_loot_table = patch_entities(base_entity)

        loaded_loot_table.seek(0)

        json.dump(current_loot_table, loaded_loot_table, indent=4)
        loaded_loot_table.truncate()
