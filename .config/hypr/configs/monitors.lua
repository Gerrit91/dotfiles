------------------
---- MONITORS ----
------------------

local notebook_display = "eDP-1"

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- @x-cellent

hl.monitor({ output = "desc:LG Electronics LG TV 0x01010101",       mode = "preferred", position = "auto", scale = "auto", mirror = notebook_display })
hl.monitor({ output = "desc:Sharp Corporation PN-R706 0x01010101",  mode = "preferred", position = "auto", scale = "auto", mirror = notebook_display })
hl.monitor({ output = "desc:Acer Technologies P5260E J60020016010", mode = "preferred", position = "auto", scale = "auto", mirror = notebook_display })

hl.monitor({ output = "desc:Dell Inc. DELL S2722QC 4X2PLD3", mode = "preferred", position = "auto", scale = "auto" })
hl.monitor({ output = "desc:Dell Inc. DELL S2722QC FDHZH24", mode = "preferred", position = "auto", scale = "auto" })


-- @FI-TS

hl.monitor({ output = "desc:HP Inc. HP Z24n G2 6CM0141CLJ", mode = "preferred", position = "1920x0", scale = "1" })
hl.monitor({ output = "desc:HP Inc. HP Z24n G2 6CM0141CCM", mode = "preferred", position = "3840x0", scale = "1" })
hl.monitor({ output = "desc:HP Inc. HP Z24n G2 6CM909242Z", mode = "preferred", position = "1920x0", scale = "1" })
hl.monitor({ output = "desc:HP Inc. HP Z24n G2 6CM90923W3", mode = "preferred", position = "3840x0", scale = "1" })

-- @Home

hl.monitor({ output = "desc:Dell Inc. DELL U3223QE 5H9X6P3", mode = "preferred", position = "auto", scale = "1.5" })

-- @Notebook

hl.monitor({
    output   = notebook_display,
    mode     = "preferred",
    position = "0x0",
    scale    = "1.5",
})
