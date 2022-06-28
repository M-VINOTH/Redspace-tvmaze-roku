sub init()
    m.spinner = m.top.findNode("spinner")
    m.showGrid = m.top.findNode("showGrid")
    m.categoryMenu = m.top.findNode("categoryMenu")

    m.top.observeField("focusedChild", "onUpdateFocusChange")
    m.categoryMenu.observeField("selectedMenuIndex", "onSelectMenuIndex")
    m.showGrid.observeField("itemSelected", "onSelectShowIndex")

    setStyle()

    m.homeController = HomeViewController()
end sub

'************
'- Function Name:  ``setStyle``
' **Description:
'************
sub setStyle()
    style = getHomeViewStyle()
    m.categoryMenu.setFields(style.categoryMenu)
    m.showGrid.setFields(style.showGrid)
end sub

'************
'- Function Name:  ``onReceivedInitData``
'- Params: event as object 
'- Return:  This function will trigger when payload has recieved
' **Description: 
sub onReceivedInitData(event as object)
    payload = event.getData()
    m.homeController.init(m.top, m.top.getScene(),m.top.payload)
    m.homeController.launch()
    m.homeController.setFocus()
end sub

'************
'- Function Name:  ``onMenuItemsReceived``
'- Params:  event as object
' **Description: This function will trigger when menuItems are recieved
'************
sub onMenuItemsReceived(event as object)
    menus = event.getData()
    m.categoryMenu.menuItems = menus
end sub

sub onShowsItemsReceived(event as object)
    shows = event.getData()
    m.showGrid.content = shows
    m.spinner.visible = false
end sub

'=========================================
'# {Start}:Top observerfield function handler
'========================================
sub onUpdateFocusChange(event as object)
    hasFocus = m.top.hasFocus()
    if hasFocus
        m.categoryMenu.setFocus(hasFocus)
    end if
end sub

sub onSelectMenuIndex(event as object)
    index = event.getData()
    m.top.selectedMenuIndex = index
end sub

sub onSelectShowIndex(event as object)
    index = event.getData()
    m.top.selectedShowIndex = index
end sub
'=========================================
'# {End}:Top observerfield function handler
'========================================


function onKeyEvent(key as string, press as boolean) as boolean
    if key = "up"
        m.categoryMenu.setFocus(true)
    else if key = "down"
        m.showGrid.setFocus(true)
    end if
end function
