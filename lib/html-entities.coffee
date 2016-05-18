Entities = null

module.exports =
  activate: (state) ->
    atom.commands.add 'atom-workspace', 'html-entitize:encode', ->
      entitiesCoderDecoder('encode')

    atom.commands.add 'atom-workspace', 'html-entitize:decode', ->
      entitiesCoderDecoder('decode')

entitiesCoderDecoder = (action) ->
  editor = atom.workspace.getActiveTextEditor()
  return unless editor?

  Entities = require('he')

  selectedText = editor.getSelectedText()
  if selectedText and action is 'decode'
    editor.insertText(Entities.decode(selectedText))

  else if selectedText
    editor.insertText(Entities.encode(selectedText, {
      'useNamedReferences': true
    }))

  else if action is 'decode'
    editor.setText(Entities.decode(editor.getText()))

  else
    editor.setText(Entities.encode(editor.getText(), {
      'useNamedReferences': true
    }))
