jQuery(document).on 'turbolinks:load', ->
  messages = $('#group_posts')
  if $('#group_posts').length > 0
    messages_to_bottom = ->
      messages.scrollTop(messages.prop("scrollHeight"))

    messages_to_bottom()
    console.log "Group.coffee"

    App.groups = App.cable.subscriptions.create "GroupChannel",
      collection: -> $("[data-channel='new_group']")
      connected: ->
        console.log "group Connected"
        console.log "messages:", messages
        console.log "messages.data", messages.data
        console.log messages.data('group-id')
        setTimeout =>
          @followCurrentMessage()

        # Called when the subscription is ready for use on the server

      disconnected: ->
        console.log "group Disconnected"
        # Called when the subscription has been terminated by the server

      received: (data) ->
        console.log "Data:", data
        messages.append data['message']
        messages_to_bottom()

      followCurrentMessage: ->
        if groupId = @collection().data('group-id')
          @perform('follow', group_id: groupId)
        else
          @perform 'unfollow'

      send_message: (message, chat_room_id) ->
        @perform 'send_message', message: message, chat_room_id: chat_room_id

  $('#new_message').submit (e) ->
    $this = $(this)
    textarea = $this.find('#message_body')
    if $.trim(textarea.val()).length > 1
      App.groups.send_message textarea.val(), messages.data('group-id')
      textarea.val('')
    e.preventDefault()
    return false