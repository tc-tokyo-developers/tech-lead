# MessageChannelを使うAppを作成
$(document).on 'turbolinks:load', ->
  $messages_element = $('#messages')
  if $messages_element.length is 0 then return false

  # 自動スクロール
  $messages_element.stop().animate({
    scrollTop: $messages_element[0].scrollHeight
  }, 0)

  chat_group_id = $messages_element.data('chat-group-id')
  App.message = App.cable.subscriptions.create {
      channel: 'ChatGroupsChannel',
      chat_group_id: chat_group_id
    },
    connected: ->

    disconnected: ->

    received: (data) ->
      is_same_type = user_type() is data['user_type']
      message = if is_same_type then data['right_message'] else data['left_message']
      $messages_element.append message

      # 自動スクロール
      $messages_element.stop().animate({
        scrollTop: $messages_element[0].scrollHeight
      }, 'normal')

    post: (content) ->
      @perform 'post', content: content, chat_group_id: chat_group_id, user_type: user_type()

  user_type = ->
    path = location.pathname
    return if path.match(/^\/chat$/) then 'student' else 'mentor'

  $('#chatSubmitButton').on 'click', (e) ->
    e.preventDefault()
    $input = $('#chatInput')
    content = $input.val()
    if content is '' then return false

    App.message.post content
    $input.val('')
