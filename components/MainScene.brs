sub init()
    m.appOverhang = m.top.findNode("appOverhang")

    topRef = m.top

    topRef.observerField("internetConnection", "onInternetConnectionChange")
    setStyles()

    m.appController = AppController()
    m.appController.init(m.top)
end sub

'************
'- Function Name:  ``setStyles``
'- Return:  return as void
' **Description: This function will get style for mainscene and set for component
'************
sub setStyles()
    styles = getMainSceneStyle()
    m.appOverhang.setFields(styles.appOverhang)
end sub

'************
'- Function Name:  ``navigateTo``
'- Params:  screenName as string
'- Params:  payload as dynamic
'- Return:  return as true
' **Description: This function will get call to handle navigation
'************
function navigateTo(screenName as string, payload as dynamic)
    m.appController.navigate(screenName,payload)
end function

'=========================================
'# {Start}:Scene ObserverField Function
'========================================

'************
'- Function Name:  ``onInternetConnectionChange``
'- Params:  event as object
' **Description: This event will receoive when internet status got change
'************
sub onInternetConnectionChange(event as object)
    isInternetConnected = event.getData()
    if not isInternetConnected
        'Handle when device got network disconnectivity
    end if
end sub
'=========================================
'# {End}:Scene ObserverField Function
'========================================
