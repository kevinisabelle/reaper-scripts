local name = "Displays the selected tracks with their FX on the console"

function getParent(track)
    return reaper.GetParentTrack(track)
end

function printTrackBasicInfo(track)
    ret, trackname = reaper.GetTrackName(track)
    trackNum = reaper.GetMediaTrackInfo_Value(track, "IP_TRACKNUMBER")
    folderDepth = reaper.GetMediaTrackInfo_Value(track, "I_FOLDERDEPTH")
    reaper.ShowConsoleMsg("\"name\": \""..trackname.."\"\n")
    reaper.ShowConsoleMsg(",\"number\": "..trackNum.."\n")
    reaper.ShowConsoleMsg(",\"depth\": "..folderDepth.."\n")

    parentTrack = getParent(track);
    if parentTrack ~= nil then
        ret, parentTrackName = reaper.GetTrackName(parentTrack)
        parentTracknum = reaper.GetMediaTrackInfo_Value(parentTrack, "IP_TRACKNUMBER")
        reaper.ShowConsoleMsg(",\"parentTrack\": { \"name\": \""..parentTrackName.."\", \"number\": "..parentTracknum.."}\n")
    else 
        reaper.ShowConsoleMsg(",\"parentTrack\": null\n")
    end
end

function printTrackFxNames(track)
    reaper.ShowConsoleMsg(", \"fx\": [")    
    fxCount = reaper.TrackFX_GetCount(track)
    local i = 0;
    while i<fxCount do
        buf = ""
        ret, fxname = reaper.TrackFX_GetFXName(track, i, buf)
        reaper.ShowConsoleMsg("{\"name\": \""..fxname.."\"},\n")
        i = i + 1
    end
    ret, trackname = reaper.GetTrackName(track)
    reaper.ShowConsoleMsg("]")
end

function printSendsList(track)
    nbSends = reaper.GetTrackNumSends(track, 0)
    nbReceives = reaper.GetTrackNumSends(track, -1)
    nbHardwareSends = reaper.GetTrackNumSends(track, 1)
    reaper.ShowConsoleMsg(",\"nbSends\": "..nbSends..",\n")
    reaper.ShowConsoleMsg("\"nbReceives\": "..nbReceives..",\n")
    reaper.ShowConsoleMsg("\"nbHardSends\": "..nbHardwareSends..",\n")

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



function printTrackBlock(track)
    reaper.ShowConsoleMsg("{")
    printTrackBasicInfo(track)
    printSendsList(track)
    printTrackFxNames(track)
    reaper.ShowConsoleMsg("},")
end

-- Main script
local i = 0
reaper.ShowConsoleMsg("[")
while reaper.GetSelectedTrack(0, i) do
    track = reaper.GetSelectedTrack(0, i)
    printTrackBlock(track)
    i = i + 1
end
reaper.ShowConsoleMsg("]")

