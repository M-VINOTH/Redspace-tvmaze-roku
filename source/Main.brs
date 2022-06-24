'*************************************************************
'** Hello World example 
'** Copyright (c) 2015 Roku, Inc.  All rights reserved.
'** Use of the Roku Platform is subject to the Roku SDK Licence Agreement:
'** https://docs.roku.com/doc/developersdk/en-us
'*************************************************************
sub Main()
    print "in showChannelSGScreen"
    'Indicate this is a Roku SceneGraph application'
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    'Create a scene and load /components/MainScene.xml'
    scene = screen.CreateScene("MainScene")
    screen.show()

    m.connection = CreateObject("roDeviceInfo")
	m.connection.SetMessagePort(m.port)
	m.connection.EnableLinkStatusEvent(true)

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        else if (msgType = "roDeviceInfoEvent")
			eventInfo = msg.getInfo()
			if (eventInfo.linkStatus <> invalid)
				scene.internetConnection = eventInfo.linkStatus
			end if
        end if
    end while
end sub

