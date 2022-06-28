sub init()
    m.posterImage = m.top.findNode("posterImage")
    m.playIcon = m.top.findNode("playIcon")

    m.top.observefield("focusedChild", "onUpdateFocusChange")
    setStyles()
end sub

sub onUpdateContent(event as object)
    showContent = event.getData()
    m.posterImage.uri = showContent.posterURL
end sub

sub onChangeFocus(event as object)
    focusPercentage = event.getData()
    m.posterImage.scale = [1.0 + (0.12 * focusPercentage), 1.0 + (0.12 * focusPercentage)]
    m.posterImage.translation = [20 - (20 * focusPercentage), 20 - (20 * focusPercentage)]
end sub

sub setStyles()
    styles = getEpisodePosterStyle()
    m.posterImage.setFields(styles.posterImage)
    m.playIcon.setFields(styles.playIcon)
end sub

sub onUpdateFocusChange()
    isFocus = m.top.hasFocus()
    if not isFocus
        m.posterImage.scale = [1.0, 1.0]
        m.posterImage.translation = [20, 20]
    end if
end sub
