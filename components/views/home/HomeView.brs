sub init()
    m.categoryMenu = m.top.findNode("categoryMenu")
end sub

'************
'- Function Name:  ``setStyle`` 
' **Description: 
'************
sub setStyle()
    style = getHomeViewStyle()
    m.categoryMenu.setFields(style.categoryMenu)
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