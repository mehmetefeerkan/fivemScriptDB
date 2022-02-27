# ZF Dialog | NoPixel Inspired Dialog Menu
Simple and Easy to use Dialog Menu (Good replacement for ESX Menu Dialog)


# Information
I really loved the NeroHiro Keyboard that he made so I've ended up re-creating a dialog menu like he had made because he unfortunately stop support it..
Hope you enjoy this "re-creation" of the nh-keyboard with a new design that is more Luxurious version of it.

![ShowCase](https://media.discordapp.net/attachments/888447971933425694/889021553034006598/unknown.png)
![ShowCase](https://media.discordapp.net/attachments/888447971933425694/889021464957833286/unknown.png)
![ShowCase](https://media.discordapp.net/attachments/888447971933425694/889021667010039808/unknown.png)


## Installation
To Install the ZF Dialog Menu, you need to down it ![Here](https://github.com/zf-development/zf_dialog/releases).
After you've downloaded the zf_dialog, install it in '[resource]/[local]/zf_dialog'.
Don't forget to start the resource in your server.cfg with `ensure zf_dialog`


## Usage
This is a default menu to show you how it works.
This is only for exemple.
```
RegisterCommand('testdialog', function()
    local dialog = exports['zf_dialog']:DialogInput({
        header = "Tuner Billing", 
        rows = {
            {
                id = 0, 
                txt = "Citizen ID (#)"
            },
            {
                id = 1, 
                txt = "Bill Price ($)"
            },
        }
    })
    
    if dialog ~= nil then
        if dialog[1].input == nil or dialog[2].input == nil then
            ESX.ShowNotification('Veuillez remplir les champs.')
        else
            ESX.ShowNotification('Citizen ID: ' .. dialog[1].input .. ' Price: ' .. dialog[2].input)
        end
    end
end, false)
```


# Support
If you find an error or have a suggestion, please feel free to help us by creating an issue on the github! [Issues](https://github.com/zf-development/zf_dialog/issues)