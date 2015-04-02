jQuery ($) ->
  $(document).ready ->
    if $('.ingrid').length

      nestedForm = $('.ingrid').last().clone()

      $('.duplicate_nested_form').click (e) ->
        e.preventDefault()

        lastNestedForm = $('.ingrid').last()
        newNestedForm  = $(nestedForm).clone()
        formsOnPage    = $('.ingrid').length

        $(newNestedForm).find('label').each ->
          oldLabel = $(this).attr 'for'
          newLabel = oldLabel.replace(new RegExp(/_[0-9]+_/), "_#{formsOnPage}_")
          $(this).attr 'for', newLabel

        $(newNestedForm).find('select, input').each ->
          oldId = $(this).attr 'id'
          newId = oldId.replace(new RegExp(/_[0-9]+_/), "_#{formsOnPage}_")
          $(this).attr 'id', newId

          oldName = $(this).attr 'name'
          newName = oldName.replace(new RegExp(/\[[0-9]+\]/), "[#{formsOnPage}]")
          $(this).attr 'name', newName

        $( newNestedForm ).insertAfter( lastNestedForm )