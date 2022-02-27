_rc_bshot

Guides/Installation:
•Import sql
•Inventory Set-up: 
    1. Put bshotstash.lua inside client folder of esx_inventoryhud (see sc1.png)
    2. Paste "client/bshotstash.lua", into fxmanifest.lua client_scripts of esx_inventoryhud (see sc2.png)
    3. Put all Images from inv folder to html/img of esx_inventoryhud
    4. Insert this lines to inventory.js
----------------------see sc3.png------------------------
            } else if (type === "bshot") {
                $(".info-div").show();
            } else if (type === "bshotStorage") {
                $(".info-div").show();

----------------------see sc4.png-------------------------
            } else if (type === "bshot" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/TakeFrombshot", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "bshotStorage" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/TakeFrombshotStorage", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));

-----------------------see sc5.png----------------------------
        } else if (type === "bshot" && itemInventory === "main") {
            disableInventory(500);
            $.post("http://esx_inventoryhud/PutIntobshot", JSON.stringify({
                item: itemData,
                number: parseInt($("#count").val())
            }));
        } else if (type === "bshotStorage" && itemInventory === "main") {
            disableInventory(500);
            $.post("http://esx_inventoryhud/PutIntobshotStorage", JSON.stringify({
                item: itemData,
                number: parseInt($("#count").val())
            }));
--------------------------------------------------------------------------
•Include all files inside utils folder to your server

ensure _rainCore
ensure _rc_menu
ensure _rc_skillbar
ensure _rc_interactions
ensure _rc_bshot
ensure bshot

--------------------------------------------------------------------------------


Need support? visit us on discord

discord.gg/121222