# Loot Table Output Specification
 
This is a utility that allows you to reliably determine where a block was broken and who or what broke it. 

## Use
For this pack to function the `doTileDrops` gamerule has to be set to `true`. 

There are 2 separate datapacks in this repo, `ltos_dotiledrops` makes blocks exhibit their vanilla block drop behavior, and `ltos_notiledrops` disables all vanilla block drops. If you have custom block loot tables in your datapack be sure to read the section below on [mixing loot tables](https://github.com/gibbsly/ltos#mixing-loot-tables)


### Function Tags
This datapack runs 3 function tags that it runs when a block is broken, in the listed order. There is context and other data stored in storage listed below.

`#ltos:as_block` - runs at the center of the block that was broken.

`#ltos:as_destroyer` - runs as an at the entity that destroyed the block. If the entity that destroyed the block is a projectile with an owner this is run as the owner of the projectile.

`#ltos:as_destroyed_block` - runs at the center of the block that was broken after the destroyer function is run.


### Context and data
while those function tags are run, there is context data in storage in `ltos:main data`.

`destroyer_uuid` - the uuid of the entity that destroyed the block, may not exist if the block was destroyed by natural means or commands.

`destroyer_owner_uuid` - the uuid of the owner of the entity that destroyed the block, may not exist.

`destroyer_tool` - the item that the entity that destroyed the block was holding. This may also be the item data for the item object in a projectile like a snowball or a trident

`destroyed_by` - the id of the entity (without the `minecraft:` prefix) that destroyed the block. If the block was destroyed by natural mens or commands the string is `"command"`

`block` - the id of the block (without the `minecraft:` prefix) that was destroyed.


## Mixing loot tables
If you have custom block loot tables in any of your packs, and want to keep the functionality of the pack you have to add an additional `pool` to your loot table, as well as enable your datapack before this one.
### Datapack order
To order datapacks correctly you will want to run `/datapack disable "file/ltos_(dotiledrops/notiledrops)"` then `/datapack enable "file/ltos_(dotiledrops/notiledrops)" last`. To be safe you should do this every time you add a new datapack.
### Adding the `pool`
The functionality of this datapack is reliant on blocks dropping a special item with specific nbt, to apply this behavior to your loot tables add the object shown below.
```json
{
  "rolls":1,
  "entries":[
    {
      "type":"minecraft:loot_table",
      "name":"ltos:data",
      "functions":[
        {
          "function":"minecraft:set_nbt",
          "tag":"{block:\"<name of the block here>\"}"
        }
      ]
    }
  ]
}
```
 An example of a loot table with this inserted would be: 
```json
{
  "type": "minecraft:block",
  "pools": [
    {"rolls": 1.0,"bonus_rolls": 0.0,"entries": [{"type": "minecraft:item","name": "minecraft:andesite"}],"conditions": [{"condition": "minecraft:survives_explosion"}]},
    {"rolls":1,"entries":[{"type":"minecraft:loot_table","name":"ltos:data","functions":[{"function":"minecraft:set_nbt","tag":"{block:\"andesite\"}"}]}]}
  ]
}
```