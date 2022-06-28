'************
'- Function Name:  ``getShowDetailStyle``
'- Return:  retrun as object
' **Description: return the styles for ShowDetail component item.
'************
function getShowDetailStyle() as object
    imageRoot = "pkg:/images/app/"
    
    styles = {
        showInfoGroup:{
            translation:[490,90],
            layoutDirection: "vert",
            vertAlignment:"top"
            horizAlignment: "left",
            itemSpacings:[20],
            visible:true
        },
        showPoster:{
            translation:[90,90]
            width:360,
            height:480,
            visible: true,
            loadWidth:360,
            loadHeight:480,
            loadDisplayMode:"scaleToFit"
        },
        showTitle:{
            height:60,
            visible: true,
            font: getFont("bold",50)
        },
        sessionInfoLabel:{
            height:60,
            visible: true,
            font: getFont("light",40)
        },
        showDescription:{
            width:900,
            height:200,
            wrap:true,
            visible: true,
            font: getFont("regular",36)
        },
        episodeGrid: {
            itemSize: [440,265],
            itemSpacings:[0,20],
            rowHeights:[265],
            columnWidths:[440,440,440,440,440,440]
            numColumns:4,
            numRows:1,
            itemComponentName:"EpisodePoster",
            visible: true,
            vertFocusAnimationStyle:"fixedFocus"
        },
        seasonNumberGrid:{
            itemSize: [90,30],
            itemSpacings:[20,20],
            rowHeights:[30],
            numRows:1
            numcolumns:9,
            itemComponentName:"MenuItemComponent",
            visible: true
        }
        bottomGroup:{
            layoutDirection: "vert",
            vertAlignment:"top"
            horizAlignment: "left",
            itemSpacings:[10],
            translation:[90,600],
            visible:true
        }
    }
    return styles
end function
