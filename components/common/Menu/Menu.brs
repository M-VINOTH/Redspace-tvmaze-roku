sub init()
    m.menuGrid = m.top.findNode("menuGrid")
    m.menuGridLayout = m.top.findNode("menuGridLayout")
    
    m.top.observeField("focusedChild","onUpdateFocusChange")
    m.menuGrid.observeField("itemSelected","onSelectMenu")
    setStyle()
end sub

sub setStyle()
    style = getMenuStyle()
    m.menuGridLayout.setFields(style.menuGridLayout)
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

'=========================================
'# {Start}:Top observer field function handler 
'========================================
 sub onUpdateFocusChange(event as object)
    hasFocus = m.top.hasFocus()
    if hasFocus
        m.menuGrid.setFocus(hasFocus)
    end if
 end sub

 sub onSelectMenu(event as object)
    index = event.getData()
    if m.top.selectedMenuIndex <> index 
        m.top.selectedMenuIndex = index 
    end if 
 end sub
'=========================================
'# {End}:Top observer field function handler 
'========================================
