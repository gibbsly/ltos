#getting owner UUID
execute store result score uuid.0 ltos.main run data get storage ltos:main data.killer_owner_uuid[0]
execute store result score uuid.1 ltos.main run data get storage ltos:main data.killer_owner_uuid[1]
execute store result score uuid.2 ltos.main run data get storage ltos:main data.killer_owner_uuid[2]
execute store result score uuid.3 ltos.main run data get storage ltos:main data.killer_owner_uuid[3]

#getting direct UUID
execute unless data storage ltos.main data.killer_owner_uuid store result score uuid.0 ltos.main run data get storage ltos:main data.killer_uuid[0]
execute unless data storage ltos.main data.killer_owner_uuid store result score uuid.1 ltos.main run data get storage ltos:main data.killer_uuid[1]
execute unless data storage ltos.main data.killer_owner_uuid store result score uuid.2 ltos.main run data get storage ltos:main data.killer_uuid[2]
execute unless data storage ltos.main data.killer_owner_uuid store result score uuid.3 ltos.main run data get storage ltos:main data.killer_uuid[3]