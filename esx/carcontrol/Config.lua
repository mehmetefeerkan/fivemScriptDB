Config = {
  Receipt = "1708", -- The 4 digit number from your site purchase. Does NOT need to include the hash.
                        -- Seriously. Don't be retarded when you set this, otherwise your request is going to linger and you won't know why the mod doesnt work 
                        -- (Balkton, and whoever else is using their paypal receipt number, this message is for you).

                        -- If your script does not authorize within 24 hours, contact us on modit.store and leave your receipt number and mod name. We'll tell you why.
                        -- You DO NOT NEED to contact us via support when you have requested authorization or if you're moving IP addresses. We can see this already,
                        -- and your ticket will only serve to slow down the response on legitimate support tickets.

  __VERSION = "1.00",   -- Don't touch this. For version checking against our backend, will only notify you when you're not up to date.
}

Controls = {
  ["Toggle"] = 56,     -- Escape key
                        -- Set this to false if you don't want to open via hotkey, and want to control the UI via the export functions. 
}
