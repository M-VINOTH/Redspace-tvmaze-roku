sub init()
    m.menuLayout = m.top.findNode("menuLayout")
    m.menuTitle = m.top.findNode("menuTitle")
    m.menuFocusIndicatorLine = m.top.findNode("menuFocusIndicatorLine")

    setStyles()
end sub

'************
'- Function Name:  ``setStyles``
'************
sub setStyles()
    style = getMenuItemComponentStyle()

    m.menuLayout.setFields(style.menuLayout)
    m.menuTitle.setFields(style.menuTitle)
    m.menuFocusIndicatorLine.setFields(style.menuFocusIndicatorLine)
end sub

'************
'- Function Name:  ``onRecivedItemContent``
'- Params:  event as object
' **Description: This function will recieve when MenuItemContentNode is recieved
'************
sub onRecivedItemContent(event as object)
    menu = event.getData()
    menu.observeField("isSelected","onSelectUpdate")
    if menu.isSelected
        m.menuTitle.font = getFont("bold",36)
    end if
    m.menuTitle.text = menu.title
    m.menuFocusIndicatorLine.width = m.menuTitle.boundingRect().width
    updateColumnWidth(menu)
end sub

sub onSelectUpdate(event as object)
    isSelected = event.getData()
    if isSelected
        m.menuTitle.font = getFont("bold",36)
    else
        m.menuTitle.font = getFont("regular",36)
    end if
 end sub

 sub updateColumnWidth(menu as object)
    parentContentNode = menu.getParent()
    gridNode = parentContentNode.getParent()
    gridNode.columnWidths.push(m.menuTitle.boundingRect().width)
 end sub