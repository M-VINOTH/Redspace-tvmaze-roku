'************
'- Function Name:  ``getHomeViewStyle``
'- Return:  retrun as object
' **Description: return the styles for HomeView component item.
'************
function getHomeViewStyle() as object
    imageRoot = "pkg:/images/app/"
    styles = {
        categoryMenu:  {
            width: 1900,
            height: 200,
            color: "0x00000099",
            visible:true
        },
    }
    return styles
end function
