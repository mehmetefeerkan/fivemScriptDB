Fallout 76 Style Lockpicking Mini-Game

There is only one Client Side Trigger to initiate the Game

----------------------------------------------------------------

TriggerEvent('lsrp-lockpick:StartLockpickfo', function(result)
    if result then
        CODE GOES HERE ON SUCCESSFUL LOCKPICK GAME
    else
        CODE GOES HERE ON FAILURE OF LOCKPICK GAME
    end
end)

--------------------------------------------------------------------


The Following Items Get added to the Database

bobbypin - Bobby Pins to Use in the Game
screwdriver - Screwdriver Required for the Game

The Game will read how many Bobbypins the user has in there inventory, if they break a bobby pin, one automatically gets removed from the users inventory,

The user requires atleast 1 screwdriver and atleast 1 bobby pin to start the mini game