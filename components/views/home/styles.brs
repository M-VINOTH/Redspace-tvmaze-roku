'************
'- Function Name:  ``getHomeViewStyle``
'- Return:  retrun as object
' **Description: return the styles for HomeView component item.
'************
function getHomeViewStyle() as object
    imageRoot = "pkg:/images/app/"
    styles = {
        layoutGroup:{
            layoutDirection: "vert",
            vertAlignment:"top"
            horizAlignment: "left",
            itemSpacings:[30],
            translation:[90,45],
            visible:true
        },
        showGrid:{
            itemSize: [340,440],
            translation: [ 60,180],
            itemSpacings:[0,20],
            rowHeights:[440,440,440],
            columnWidths:[340,340,340,340,340,340]
            numColumns:5,
            numRows:3,
            itemComponentName:"ShowPoster",
            visible: true,
            vertFocusAnimationStyle:"fixedFocus"
        },
        categoryMenu:  {
            width: 1900,
            height: 200,
            color: "0x00000099",
            visible:true,
            
        },
    }
    return styles
end function
