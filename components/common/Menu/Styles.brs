'************
'- Function Name:  ``getMenuStyle``
'- Return:  retrun as object
' **Description: return the styles for Menu component item.
'************
function getMenuStyle() as object
    imageRoot = "pkg:/images/app/"
    styles = {
        menuGrid:  {
            itemSize: [300,60],
            translation: [ 130, 160 ],
            itemSpacings: [10,10],
            rowHeights:[60],
            numRows:1
            itemComponentName:"MenuItemComponent"
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
            itemSpacings:[30],
            translation:[0,0],
            visible:true
        },
        menuTitle:  {
            visible:true
        },
        menuFocusIndicatorLine:  {
            visible:true
            width: 300,
            height: 6,
            color:"0xff44ff66"
        }
    }
    return styles
end function