local name = "Displays unique fx with count"

local i = 0
fxTable = {}
reaper.ShowConsoleMsg("[")
while reaper.GetSelectedTrack(0, i) do
    track = reaper.GetSelectedTrack(0, i)
    fxCount = reaper.TrackFX_GetCount(track)
    local j = 0;
    while j<fxCount do
        buf = ""
        ret, fxname = reaper.TrackFX_GetFXName(track, j, buf)
        if fxTable[fxname] == nil then
            fxTable[fxname] = 1
        else 
            fxTable[fxname] = fxTable[fxname] + 1;
        end
        j = j + 1
    end
    i = i + 1
end

for k, v in pairs(fxTable) do
    reaper.ShowConsoleMsg("{\""..k.."\": "..v.."},")
end


reaper.ShowConsoleMsg("]")

