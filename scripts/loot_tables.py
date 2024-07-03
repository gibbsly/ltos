import json
from os import path
from pathlib import Path

script = Path(__file__)
name, ext = path.splitext(path.basename(script))

ltos_dir = script.parents[1].absolute()
loot_tables_dir = path.join(ltos_dir, "ltos/data/minecraft/loot_table")


def patch_blocks(base):
    structure = {
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

    return structure


def patch_entities(base):
    structure = {
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

    return structure


for loot_table in Path(path.join(loot_tables_dir, "blocks")).glob("*.json"):
    with open(loot_table, "r+") as loaded_loot_table:
        current_loot_table = json.load(loaded_loot_table)
        base_block = path.splitext(path.basename(loot_table))[0]

        ltos = False
        if len(current_loot_table.get("pools", "")) > 0:
            for pool in current_loot_table["pools"]:
                if len(pool["entries"]) > 0:
                    if pool["entries"][0].get("value", "") == "ltos:data":
                        ltos = True

        if not ltos:
            if "pools" not in current_loot_table:
                current_loot_table["pools"] = [
                    patch_blocks(base_block)]
            else:
                current_loot_table["pools"].append(
                    patch_blocks(base_block))

        loaded_loot_table.seek(0)

        json.dump(current_loot_table, loaded_loot_table, indent=4)
        loaded_loot_table.truncate()


for loot_table in Path(path.join(loot_tables_dir, "entities")).glob("*.json"):
    with open(loot_table, "r+") as loaded_loot_table:
        current_loot_table = json.load(loaded_loot_table)
        base_entity = path.splitext(path.basename(loot_table))[0]

        ltos = False
        if len(current_loot_table.get("pools", "")) > 0:
            for pool in current_loot_table["pools"]:
                if len(pool["entries"]) > 0:
                    if pool["entries"][0].get("value", "") == "ltos:entity_data":
                        ltos = True

        if not ltos:
            if "pools" not in current_loot_table:
                current_loot_table["pools"] = [
                    patch_entities(base_entity)]
            else:
                current_loot_table["pools"].append(
                    patch_entities(base_entity))

        loaded_loot_table.seek(0)

        json.dump(current_loot_table, loaded_loot_table, indent=4)
        loaded_loot_table.truncate()
