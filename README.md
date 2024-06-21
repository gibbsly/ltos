# Loot Table Output Specification
 
This is a utility that allows you to reliably determine where a block was broken and who or what broke it, as well as where an entity was killed and who or what killed it. 

## Use
For this pack to function the `doTileDrops` and `doMobLoot` gamerules have to be set to `true`. 

In this repo there is the core datapack as well as a folder with alternative loot tables that disable the vanilla item drops. If you have custom block or mob loot tables in your datapack be sure to read the section below on [mixing loot tables](https://github.com/gibbsly/ltos#mixing-loot-tables)


### Function Tags
#### Blocks
This datapack runs a function tag when a block is broken. There are macro arguments that contain some context and additional context and data stored in storage listed below.

##### `#ltos:block_broken`  
runs at the center of the block that was broken. 

Macro arguments
> `destroyer` - the uuid of the entity that destroyed the block, `"-"` if not present

#### Entities
This datapack runs a function tag when an entity is killed. There are macro arguments that contain some context and additional context and data stored in storage listed below.

##### `#ltos:entity_killed`
runs where the entity that was killed was killed.

Macro arguments
> `killer` - the uuid of the entity that killed the killed entity, `"-"` if not present
> 
> `killed` - the uuid of the entity that was killed, `"-"` if not present (this shouldn't happen)


### Context and data
while those function tags are run, there is context data in storage in `ltos:main data`.
#### Blocks
> `destroyer_uuid` - the uuid of the entity that destroyed the block, may not exist if the block was destroyed by natural means or commands.
> 
> `destroyer_owner_uuid` - the uuid of the owner of the entity that destroyed the block, may not exist.
> 
> `destroyer_tool` - the item that the entity that destroyed the block was holding. This may also be the item data for the item object in a projectile like a snowball or a trident
> 
> `block` - the id of the block (without the `minecraft:` prefix) that was destroyed.

#### Entities
> `killer_uuid` - the uuid of the entity that killed the entity, may not exist if the entity was killed by natural means or commands.
> 
> `killer_owner_uuid` - the uuid of the owner of the entity that killed the entity, may not exist.
> 
> `killer_weapon` - the item that the entity that killed the entity was holding. This may also be the item data for the item object in a projectile like a snowball or a trident
> 
> `entity` - the id of the entity (without the `minecraft:` prefix) that was killed.
> 
> `entity_uuid` - the int array uuid of the entity that was killed.
> 
> `entity_tags` - the `Tags` array of the entity that was killed.


## Mixing loot tables
If you have custom block loot tables in any of your packs, and want to keep the functionality of the pack you have to add an additional `pool` to your loot table, as well as enable your datapack before this one.
### Datapack order
To order datapacks correctly you will want to run `/datapack disable "file/ltos_(dotiledrops/notiledrops)"` then `/datapack enable "file/ltos_(dotiledrops/notiledrops)" last`. To be safe you should do this every time you add a new datapack.
### Adding the `pool`
The functionality of this datapack is reliant on blocks/entities dropping a special item with specific nbt, to apply this behavior to your loot tables, add the object shown below.
#### Blocks
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
          "tag":"{block:'<id of the block here>'}"
        }
      ]
    }
  ]
}
```
#### Entities
```json
{
  "rolls":1,
  "entries":[
    {
      "type":"minecraft:loot_table",
      "name":"ltos:entity_data",
      "functions":[
        {
          "function":"minecraft:set_nbt",
          "tag":"{entity:'<id of the entity here>'}"
        }
      ]
    }
  ]
}
```

 An example of a block loot table with this inserted would be: 
```json
{
  "type": "minecraft:block",
  "pools": [
    {"rolls": 1.0,"bonus_rolls": 0.0,"entries": [{"type": "minecraft:item","name": "minecraft:andesite"}],"conditions": [{"condition": "minecraft:survives_explosion"}]},
    {"rolls":1,"entries":[{"type":"minecraft:loot_table","name":"ltos:data","functions":[{"function":"minecraft:set_nbt","tag":"{block:\"andesite\"}"}]}]}
  ]
}
```
