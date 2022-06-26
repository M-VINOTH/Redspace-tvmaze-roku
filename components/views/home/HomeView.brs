sub init()
    m.categoryMenu = m.top.findNode("categoryMenu")

    m.top.observeField("focusedChild","onUpdateFocusChange")
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

'=========================================
'# {Start}:Top observerfield function handler 
'========================================
 sub onUpdateFocusChange(event as object)
    hasFocus = m.top.hasFocus()
    if hasFocus
        m.categoryMenu.setFocus(hasFocus)
    end if
 end sub
'=========================================
'# {End}:Top observerfield function handler 
'========================================
