# Based on https://github.com/LoicLBD/underscore

{CompositeDisposable} = require 'atom'

module.exports = InsertNumericalSeries =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'insert-numerical-series:run': => @run()

  deactivate: ->
    @subscriptions.dispose()

  run: ->
    editor = atom.workspace.getActiveTextEditor()

    i = 0

    selections = editor.getSelections()
    selections.sort((a, b) ->
      a_r = a.getBufferRange()
      b_r = b.getBufferRange()
      if a_r.start.row < b_r.start.row
          return -1
      if a_r.start.row > b_r.start.row
          return 1
      if a_r.start.column < b_r.start.column
          return -1
      return 1
    )

    for selection in selections
      range = selection.getBufferRange()
      editor.setTextInBufferRange(range, i.toString())
      i += 1
