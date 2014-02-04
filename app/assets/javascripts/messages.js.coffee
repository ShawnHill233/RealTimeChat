$ ->
  lastId = 0
  chat_window = $('.chat-window')

  scrollDown = ->
    chat_height = chat_window[0].scrollHeight
    chat_window.scrollTop(chat_height)

  scrollDown()

  $('[type=submit]').click (e) ->
    window.alert("i am in..")
    nick = $('[name=nick]')
    message = $('[name=message[msg]]')
    e.preventDefault()

    $.ajax
      url: 'http://localhost:3000/incoming'
      method: 'POST'
      data:
        nick: nick.val()
        message: message.val()
      dataType: 'json'

    message.val('')

  setInterval ->
    $.ajax
      url: 'http://localhost:3000/outgoing'
      method: 'GET'
      dataType: 'json'
      data:
        last_id: lastId
      success: (data, status, xhr) ->
        for messageObject in data
          messageRow = $("<div class='message'></div>")
          timestamp = $("<span class='timestamp'>&nbsp</span>")
          timestamp.text(messageObject.time)

          nick = $("<span class='nick'></span>")
          nick.text(messageObject.user_id)

          message = $("<span class='message-text'></span>")
          message.text(messageObject.msg)

          messageRow.append(nick)
          messageRow.append(timestamp)
          messageRow.append(message)

          $(".chat-window").append(messageRow)
          scrollDown()

          lastId = messageObject.id if messageObject.id > lastId
  , 1000
