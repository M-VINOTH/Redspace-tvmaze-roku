sub init()
    m.menuGrid = m.top.findNode("menuGrid")

    setStyle()
end sub

sub setStyle()
    style = getMenuStyle()

    m.menuGrid.setFields(style.menuGrid)

end sub

'************
'- Function Name:  ``onReceiveMenuItems``
'- Params:  event as object
' **Description**: This function will fire when menus contentNode received 
'************
sub onReceiveMenuItems(event as object)
    menuContentNode = event.getData()
    numbersOfMenu = menuContentNode.getChildCount()
    m.menuGrid.numColumns = numbersOfMenu
    m.menuGrid.content = menuContentNode
end sub