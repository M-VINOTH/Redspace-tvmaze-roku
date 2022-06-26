'************
'- Function Name:  ``getMenuStyle``
'- Return:  retrun as object
' **Description: return the styles for Menu component item.
'************
function getMenuStyle() as object
    imageRoot = "pkg:/images/app/"
    styles = {
        menuGrid:  {
            itemSize: [160,60],
            translation: [ 10, 0 ],
            rowHeights:[60],
            numRows:1
            itemComponentName:"MenuItemComponent",
            visible: true
        },
        menuGridLayout: {
            layoutDirection: "vert",
            vertAlignment:"top"
            horizAlignment: "center",
            itemSpacings:[10],
            translation:[960,45],
            visible:true
        }
    }
    return styles
end function

'************
'- Function Name:  ``getMenuItemComponentStyle``
'- Return:  retrun as object
' **Description: return the styles for Menu item component.
'************
function getMenuItemComponentStyle() as object
    imageRoot = "pkg:/images/app/"
    styles = {
        menuLayout:  {
            layoutDirection: "vert",
            vertAlignment:"top"
            horizAlignment: "left",
            itemSpacings:[5],
            translation:[20,0],
            visible:true
        },
        menuTitle:  {
            visible:true
        },
        menuFocusIndicatorLine:  {
            visible:false
            width: 100,
            height: 10,
            color:"0xff44ff66"
        }
    }
    return styles
end function