'************
'- Function Name:  ``getEpisodePosterStyle``
'- Return:  retrun as object
' **Description: return the styles for Episode Poster component item.
'************
function getEpisodePosterStyle() as object
    imageRoot = "pkg:/images/app/"
    styles = {
        posterImage:  {
            width:400,
            height:225,
            translation:[20,20],
            visible: true,
            loadWidth:400,
            loadHeight:225,
            loadDisplayMode:"scaleToFit"
        },
        playIcon:{
            width:80,
            height:80,
            translation:[160,72],
            uri:"pkg:/images/PlayCircle.png"
            visible: true,
            loadWidth:80,
            loadHeight:80,
            loadDisplayMode:"scaleToFit"
        }
    }
    return styles
end function

