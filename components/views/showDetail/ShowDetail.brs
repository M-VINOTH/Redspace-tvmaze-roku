sub init()
    m.bottomGroup = m.top.findNode("bottomGroup")
    m.seasonNumberGrid = m.top.findNode("seasonNumberGrid")
    m.episodeGrid = m.top.findNode("episodeGrid")
    
    m.topGroup = m.top.findNode("topGroup")
    m.showPoster = m.top.findNode("showPoster")
    m.showDescription = m.top.findNode("showDescription")
    m.showTitle = m.top.findNode("showTitle")
   

    m.top.observeField("focusedChild", "onUpdateFocusChange")

    m.episodeGrid.observeField("itemSelected", "onSelectEpisode")
    m.seasonNumberGrid.observeField("itemSelected", "onSelectSeason")

    setStyle()
end sub

'************
'- Function Name:  ``setStyle``
' **Description:
'************
sub setStyle()
    styles = getShowDetailStyle()
    m.seasonNumberGrid.setFields(styles.seasonNumberGrid)
    m.episodeGrid.setFields(styles.episodeGrid)
    m.bottomGroup.setFields(styles.bottomGroup)
    m.topGroup.setFields(styles.topGroup)
    m.showPoster.setFields(styles.showPoster)
    m.showDescription.setFields(styles.showDescription)
    m.showTitle.setFields(styles.showTitle)
end sub
'************
'- Function Name:  ``onReceivedShow``
'- Params:  event as object
' **Description: This function will trigger when selected show has recieved
'************
sub onReceivedShow(event as object)
    show = event.getData()
    m.showPoster.uri = show.posterURL
    m.showTitle.text = show.title
    m.showDescription.text = show.description
end sub

'************
'- Function Name:  ``onReceivedEpisodes``
'- Params:  event as object
' **Description: This function will trigger when episodes are recieved for selectedSeason
'************
sub onReceivedEpisodes(event as object)
    episodes = event.getData()
    m.episodeGrid.content = episodes
end sub

'************
'- Function Name:  ``onReceivedSeasonNumber``
'- Params:  event as object
' **Description: This function will trigger when season number are received
'************
sub onReceivedSeasonNumber(event as object)
    seasonNumbers = event.getData()
    m.seasonNumberGrid.content = seasonNumbers
end sub


'=========================================
'# {Start}:Top observerfield function handler
'========================================
sub onUpdateFocusChange(event as object)
    hasFocus = m.top.hasFocus()
    if hasFocus
        m.episodeGrid.setFocus(hasFocus)
    end if
end sub

sub onSelectSeason(event as object)
    index = event.getData()
    if m.top.selectedSeasonIndex  <> index
        m.top.selectedSeasonIndex = index
    end if
end sub

sub onSelectEpisode(event as object)
    index = event.getData()
    m.top.selectedEpisodeIndex = index
end sub

'************
'- Function Name:  ``onkeyEvent``
'************
function onKeyEvent(key as string, press as boolean) as boolean
    if key = "up"
        m.seasonNumberGrid.setFocus(true)
    else if key = "down"
        m.episodeGrid.setFocus(true)
    end if
end function