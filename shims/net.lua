-- normal net.writeTable is very large, these functions reduce the size by 75% or more
function net.writeTable(tbl)
    local compressedData = fastlz.compress(json.encode(tbl))
    net.writeInt(#compressedData, 32)
    net.writeData(compressedData, #compressedData)
end

function net.readTable()
    local data = net.readData(net.readInt(32))
    return json.decode(fastlz.decompress(data))
end