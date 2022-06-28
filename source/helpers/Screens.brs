'************
'- Function Name:  ``getScreens`` 
'- Return:  return as object
' **Description**: This function will return the Screen template info
'************
function getScreens() as object
    this  = {
        HOME_VIEW: "HomeView",
        SHOW_DETAIL:"ShowDetail"
        VIDEO_VIEW: "VideoPlayer"
    }
    return this
end function
