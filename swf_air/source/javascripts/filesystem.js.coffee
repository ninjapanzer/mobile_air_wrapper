localfile = ->
  prefsFile = air.File.applicationStorageDirectory.resolvePath("prefs.pnz")
  air.trace("allocate File")
  stream = new air.FileStream()
  stream.open(prefsFile, air.FileMode.WRITE)
  air.trace("write hi")
  stream.writeUTFBytes("hi")
  stream.close()
  air.trace("close")

  stream.open(prefsFile, air.FileMode.READ)
  prefsXML = stream.readUTFBytes(stream.bytesAvailable)
  air.trace(prefsXML)
  stream.close()
  return

remoturl = ->
  stream = null
  bytes = new air.ByteArray()
  start = ->
    url = "http://samples.mplayerhq.hu/SWF/compressed-swf/FLV_player_demo.swf"
    stream = new air.URLStream()
    request = new air.URLRequest url
    listenerDelegate stream
    stream.load request
    return

  listenerDelegate = (dispatcher)->
    dispatcher.addEventListener(air.Event.COMPLETE, completeHandler);
    return

  completeHandler = (evnt)->
    air.trace(stream.bytesAvailable)
    air.trace("version :" + stream.readBytes(bytes))
    air.trace(bytes.length)
    air.trace(stream.bytesAvailable)
    #air.trace(bytes)
    return

  start()
  return

class CacheResource

  constructor: (@url) ->
    air.trace("constructor")
    @complete = false
    @bytes = new air.ByteArray()
    @stream = new air.URLStream()
    @request = new air.URLRequest @url
    @listenerDelegate @stream
    @stream.load @request
    air.trace("finish Constructor")
    return

  listenerDelegate: (dispatcher)->
    dispatcher.addEventListener(air.Event.COMPLETE, (e) => @completeHandler(e) );
    return

  completeHandler: (evnt)->
    air.trace("Complete Called")
    @complete = true
    air.trace("complete Set")
    @stream.readBytes(@bytes)
    @writeFile("thing")
    air.trace("Files Written")
    return

  getFile: ->
    if @complete
      air.trace(@bytes)
    else
      air.trace("Still Loading")
    return

  writeFile: (filename)->
    fstream = new air.FileStream()
    privatefile = air.File.applicationStorageDirectory.resolvePath("something.swf")
    userfile = air.File.documentsDirectory.resolvePath("something.swf")
    fstream.open(privatefile, air.FileMode.WRITE)
    fstream.writeBytes(@bytes)
    fstream.close()
    fstream.open(userfile, air.FileMode.WRITE)
    fstream.writeBytes(@bytes)
    fstream.close()
    return


#localfile()
#remoturl()
#rec = new CacheResource("http://samples.mplayerhq.hu/SWF/compressed-swf/FLV_player_demo.swf")

