local name = "Displays the selected tracks with their FX on the console"

function printTrackName (track)
    ret, trackname = reaper.GetTrackName(track)
    reaper.ShowConsoleMsg("\"track\": \""..trackname.."\"\n")
end

function printTrackFxNames(track)

    fxCount = reaper.TrackFX_GetCount(track)
    local i = 0;
    while i<fxCount do
        buf = ""
        ret, fxname = reaper.TrackFX_GetFXName(track, i, buf)
        reaper.ShowConsoleMsg("{\"name\": \""..fxname.."\"},\n")
        i = i + 1
    end
    ret, trackname = reaper.GetTrackName(track)

end

function printSendsList(track)
    nbSends = reaper.GetTrackNumSends(track, 0)
    nbReceives = reaper.GetTrackNumSends(track, -1)
    reaper.ShowConsoleMsg(",\"nbSends\": \""..nbSends.."\",\n")
    reaper.ShowConsoleMsg("\"nbReceives\": \""..nbReceives.."\",\n")

    reaper.ShowConsoleMsg("\"sends\": [\n")
    local i = 0
    while i < nbSends do
        buf = "";
        retval, sendName = reaper.GetTrackSendName(track, i, buf)
        reaper.ShowConsoleMsg("{")
        reaper.ShowConsoleMsg("\"name\": \""..sendName.."\"\n")
        reaper.ShowConsoleMsg("},")
        i = i + 1;
    end
    reaper.ShowConsoleMsg("]")
end

local i = 0
reaper.ShowConsoleMsg("[")
while reaper.GetSelectedTrack(0, i) do
    reaper.ShowConsoleMsg("{")
    track = reaper.GetSelectedTrack(0, i)
    
    printTrackName(track)
    -- printTrackVolume(track)
    -- printTrackPan(track)
    printSendsList(track)
    reaper.ShowConsoleMsg(", \"fx\": [")
    printTrackFxNames(track)
    reaper.ShowConsoleMsg("]},")
    i = i + 1
end
reaper.ShowConsoleMsg("]")

