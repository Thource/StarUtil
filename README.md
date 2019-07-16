# StarUtil

StarUtil is a utility kit designed to add missing functionality and enhance existing functionality of Starfall - A lua based programming language in WireMod, a Garry's Mod addon.

## Installation
`SF` = `GMOD_INSTALL_LOCATION/data/starfall/`

While I recommend installing StarUtil at `SF/lib/`, it's ultimately your choice where you decide to install it.

```sh
cd SF
mkdir lib
cd lib
git clone https://github.com/Thource/star_util
```

## Usage
You can require the library with:
```lua
--@includedir lib/star_util
requiredir("lib/star_util")
```

Alternatively, you can include just the components you need with:
```lua
--@include lib/star_util/class.lua
require("lib/star_util/class.lua")
```

## Documentation
Coming soon