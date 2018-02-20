# MessageChannelを使うAppを作成
$(document).on 'turbolinks:load', ->
  $messages_element = $('#messages')
  if $messages_element.length is 0
    return false

  chat_group_id = $messages_element.data('chat-group-id')
  App.message = App.cable.subscriptions.create {
      channel: 'ChatGroupsChannel',
      chat_group_id: chat_group_id
    },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      console.log(data)
      if user_type() is data['user_type']
        $messages_element.append data['right_message']
      else
        # left
        $messages_element.append data['left_message']

      # 自動スクロール
      $messages_element.stop().animate({
        scrollTop: $messages_element[0].scrollHeight
      }, 'normal')

    post: (content) ->
      @perform 'post', content: content, chat_group_id: chat_group_id, user_type: user_type()

  user_type = ->
    path = location.pathname
    if path.match(/^\/chat$/)
      return 'student'
    else
      return 'mentor'

  $('#chatSubmitButton').on 'click', (e) ->
    e.preventDefault()
    $input = $('#chatInput')
    content = $input.val()
    if content is ''
      return false

    App.message.post content
    $input.val('')
