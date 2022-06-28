sub init()
    m.player = m.top.findNode("player")

    setStyle()

    m.videoViewController = VideoPlayerViewController()
end sub

sub setStyle()
    styles = getVideoPlayerStyle()
    m.player.setFields(styles.player)
end sub

'************
'- Function Name:  ``onReceivedInitData``
'- Params: event as object 
'- Return:  This function will trigger when payload has recieved
' **Description: 
sub onReceivedInitData(event as object)
    payload = event.getData()
    m.videoViewController.init(m.top, m.top.getScene(),m.top.payload)
    m.videoViewController.launch()
    m.videoViewController.setFocus()
end sub

'************
'- Function Name:  ``onVideoContentRecieved``
'************
sub onVideoContentRecieved(event as object)
    videoContent = event.getData()
    m.player.content = videoContent
    m.player.control = "play"
end sub