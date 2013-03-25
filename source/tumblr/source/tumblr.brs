'
' application wide tumblr object
'
' It can be used to perform general tumblr queries
' It should have a lifetime that matches the app lifetime
' since this will initialize and release tumblr specific resources.
'

Function Tumblr() As Object
    ' global singleton
    ' if m.tumblr=invalid then m.tumblr = InitTumblr()
    ' trust that main has done this already and remove check for better performance
    return m.tumblr
End Function

Function InitTumblr() As Object
    ' constructor
    this = CreateObject("roAssociativeArray")
    this.server = "api.tumblr.com"
    this.protocol = "http"
    this.prefix = this.protocol + "://" + this.server

    this.ShowPostCanvas = show_post_canvas
    
    print "Tumblr: init complete"
    return this
End Function


Function init_post() As Object
    o = CreateObject("roAssociativeArray")

    o.ImageSource      = ""
    o.Content          = ""
    o.UserName         = ""

    return o
End Function

Function show_post_canvas() As Void

    http = NewHttp(m.prefix + "/v2/user/dashboard")
    oa = Oauth()
    oa.sign(http,false)
    rsp = http.getToStringWithTimeout(10)

    m.json = ParseJSON(rsp)
    print rsp
    return
    
End Function
