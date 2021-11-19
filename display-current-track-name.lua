local name = "Displays the tracks on the console"

track = reaper.GetSelectedTrack(0, 0)
-- visibleChain = reaper.TrackFX_GetChainVisible(track)
ret, trackname = reaper.GetTrackName(track)

reaper.ShowConsoleMsg("Track: "..trackname)
