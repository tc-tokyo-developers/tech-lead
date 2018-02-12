# MessageChannelを使うAppを作成
$(document).on 'turbolinks:load', ->
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

      # 自動スクロール
      $('#messages').stop().animate({
        scrollTop: $('#messages')[0].scrollHeight
      }, 'normal')

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


# 送信ボタンで送信
$(document).on 'click', '#chatSubmitButton', (e) ->
  e.preventDefault()
  $input = $('#chatInput')
  content = $input.val()
  if content is ''
      return false

  App.message.post content
  $input.val('')
