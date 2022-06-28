sub init()
    m.player = m.top.findNode("player")

    setStyle()
end sub

sub setStyle()
    styles = getVideoPlayerStyle()
    m.player.setFields(styles.player)
end sub

'************
'- Function Name:  ``onVideoContentRecieved``
'************
sub onVideoContentRecieved(event as object)
    videoContent = event.getData()
    m.player.content = videoContent
    m.player.control = "play"
end sub