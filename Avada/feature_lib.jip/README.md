# Feature Lib


Feature Lib is a simple libary to solve the item usage conflicts

# Usage (User)

  - Download this libary as [.zip file][z1]
  - Unpack the .zip into your scripts folder
  - The Folder stucture should look like this
      ```
      scripts
        feature_lib.jip
            main.lua
            header.lua
            menu.lua
      ```
  - Once in-game open the feature lib menu and select your favorite scripts for each item
  - If your Script is not appearing in the menu, please ask the Developer to add support for this lib 
     - Give him a link to this site

# Usage (Developer)
  - Download and install this lib, as described above
  - Load the lib using ```local flib = loadmodule("featurelib")```
  - Use this snippet to register an item:
    ```
    flib.registeritem("Item Name", "Script Name")
    --Example:
    flib.registeritem("Tiamat", "Avada Soraka")
    -- Item Names are NOT case sensitive
    ```
  - Use this snippet to find out, if the user allows your script to use the item
      ```
      local go_ahead = flib.caniuse("Item Name", "Script Name")
      --Example:
      local go_ahead = flib.caniuse("Tiamat", "Avada Soraka")
      ```
  - If the return value is true, you are free to use the item.
  - If it is false, then the item is handled by another script or the user
  - If you are worried about the performance do do this little test:
    ```
    local flib = loadmodule("featurelib")
    flib.registeritem("Tiamat", "Script 1")
    flib.registeritem("Tiamat", "Script 2")
    local osc = os.clock
    local t = osc()
    for i=1,50000 do
      local a = flib.caniuse("Tiamat", "Script 2")
    end
    local t2 = osc()
    print(t2-t)
      ```
  - As you can see, even when looping the function 50k times, the time that has elapsed is negligible
  

 [z1]: https://gitlab.soontm.net:1337/Avada/feature_lib.jip/repository/master/archive.zip