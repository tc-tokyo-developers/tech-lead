# MessageChannelを使うAppを作成
App.message = App.cable.subscriptions.create 'MessageChannel',
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data['chat_group_id'] isnt parseInt(chat_group_id_from_path(), 10)
      return

    if user_type() is data['user_type']
      $('#messages').append(data['right_message'])
    else
      # left
      $('#messages').append(data['left_message'])

  post: (content) ->
    chat_group_id = chat_group_id_from_path()
    if chat_group_id is false
      return

    # TODO: 暗号化
    user_id = $('#user_id').val()

    @perform 'post', content: content, chat_group_id: chat_group_id, user_id: user_id, user_type: user_type()


user_type = ->
  path = location.pathname
  if path.match(/^\/chat$/)
    return 'student'
  else
    return 'mentor'


# pathからchat_group_idを取得する()
chat_group_id_from_path = ->
  if user_type() is 'student'
    # TODO: 暗号化
    return $('#chat_group_id').val()

  # /mentor/chat_groups/:id
  path = location.pathname
  CHAT_GROUP_ID_REGEXP = /^\/mentor\/chat_groups\/(\d+)$/
  matched_id = path.match(CHAT_GROUP_ID_REGEXP)

  if matched_id.length is 1
    return false
  else
    return matched_id[1]


# Enterキーで送信
$(document).on 'keypress', '[data-behavior~=message_input]', (e) ->
  if e.keyCode is 13
    e.preventDefault()
    content = e.target.value
    if content is ''
      return

    App.message.post content
    e.target.value = ''


# 送信ボタンで送信
$(document).on 'click', '[data-behavior~=message_input]', (event) ->
  event.preventDefault()
  $input = $('textarea[data-behavior~=message_input]')
  content = $input.value
  if content is ''
      return

  App.message.post content
  $input.value = ''
