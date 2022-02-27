# newspaper

## Requirements
- NONE

## ESX Users
If you're using ESX make sure to comment in 18 and 24 in the fxmanifest

### JailTrigger Usage
Client.lua
```
TriggerServerEvent('newspaper:jail', firstname, lastname, jailTime)
```
Server.lua
```
TriggerEvent('newspaper:jail', firstname, lastname, jailTime)
```
### Manually
- Download
- Put it in the `resources` directory
- run SQL file for database

## Installation
- run SQL file to put newspaper into database

- Add this in your `server.cfg`:
```
start newspaper
```

### Discord Help

make a ticket at https://discord.gg/devrp for help

# Legal
### License
Newspaper - by NuketheWhales7

Copyright (C) 2015-2020 NuketheWhales7
