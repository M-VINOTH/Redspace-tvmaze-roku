'************
'- Function Name:  ``getShowPosterStyle``
'- Return:  retrun as object
' **Description: return the styles for Menu component item.
'************
function getShowPosterStyle() as object
    imageRoot = "pkg:/images/app/"
    styles = {
        posterImage:  {
            width:300,
            height:400,
            translation:[20,20],
            visible: true,
            loadWidth:300,
            loadHeight:400,
            loadDisplayMode:"scaleToFit"
        }
    }
    return styles
end function

