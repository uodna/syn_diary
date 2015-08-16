# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  marked.setOptions({
    breaks: true,
    sanitize: true
  });

  markedExec = ->
    targets = $(".marked")
    targets.map ->
      if $(this).data("marked")
        return
      markedString = marked($(this).text())
      $(this).html(markedString)
      $(this).data("marked", true)

  markedExec()

  $("#diary_date").datepicker({
    dateFormat: "yy-mm-dd",
    onSelect: ->
      $.ajax({
        url: $("#js-api-url").val(),
        data : { date: $("#diary_date").val() },
        success: (json) -> 
          $("#diary_diary").val(json.diary.diary)
        error: ->
          alert "取得に失敗しました"
      });
  });

  $(".comments-create").submit (event) ->
    self = this
    $.ajax({
      method: "post",
      url: $(this).attr("action"),
      data : $(this).serialize(),
      success: (json) -> 
        if json.status == "success"
          commentsBox = $(self).closest(".diary").find(".comments-list")

          template = []
          template.push '<div class="span8">'
          template.push ' <div class="comment">'
          template.push '  <div class="comment-owner">'
          template.push '   ${commentOwner}がコメントしました&nbsp;<span class="comment--created-at">${commentCreatedAtJst}</span>'
          template.push '  </div>'
          template.push '  <div class="marked">\n${commentBody}</div>'
          template.push ' </div>'
          template.push '</div>'

          $.template("template", template.join(""));
          tmpl = $.tmpl("template", {
            commentOwner: json.comment.user.full_name,
            commentBody: json.comment.comment,
            commentCreatedAtJst : json.comment.created_at_jst
          })
          commentsBox.prepend(tmpl)
          $(self).find(".comment-textarea").val("")

          markedExec()
        else
          $(self).append('<p class="text-error">' + json.message + '</p>')
      error: ->
        alert "登録に失敗しました"
    })
    return false

  $(".comments--display").click (event) ->
    $(this).closest(".diary").find(".comments--form").show()
    event.preventDefault()

$(document).ready(ready)
$(document).on('page:load', ready)