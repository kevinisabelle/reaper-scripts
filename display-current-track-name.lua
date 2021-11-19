local name = "Displays the tracks on the console"

track = reaper.GetSelectedTrack(0, 0)
if track == nil then 
    reaper.ShowConsoleMsg("No tracks are selected")
    return 
end
-- visibleChain = reaper.TrackFX_GetChainVisible(track)
ret, trackname = reaper.GetTrackName(track)
buf = ""
ret, fxname = reaper.TrackFX_GetFXName(track, 0, buf)
reaper.ShowConsoleMsg("Track: "..trackname..", Fx name: "..fxname.."\n")
