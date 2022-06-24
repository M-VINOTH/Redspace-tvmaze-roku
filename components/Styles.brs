'************
'- Function Name:  ``getMainSceneStyle``
'- Return:  retrun as object
' **Description: return the styles for MainScene component item.
'************
function getMainSceneStyle() as object
    imageRoot = "pkg:/images/app/"
    styles = {
        appOverhang:  {
            width: 1920,
            height: 1080,
            logoUri: " "
            showClock: false,
            color: "0x00000099"
        },
    }
    return styles
end function