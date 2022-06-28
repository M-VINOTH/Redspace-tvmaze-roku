'************
'- Function Name:  ``getVideoPlayerStyle``
'- Return:  retrun as object
' **Description: return the styles for MainScene component item.
'************
function getVideoPlayerStyle() as object
    imageRoot = "pkg:/images/app/"
    styles = {
       player:{
        width:1920,
        height:1080,
        visible:true
       }
    }
    return styles
end function
