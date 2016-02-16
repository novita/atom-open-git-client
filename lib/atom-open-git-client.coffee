{CompositeDisposable} = require 'atom'
{exec} = require 'child_process'

module.exports = AtomOpenGitClient =
  subscriptions: null,
  config:
      OpenCommand:
          type: 'string'
          default: "GitUp.app"

  activate: (state) ->
    @openCommand = atom.config.get "atom-open-git-client.OpenCommand"
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-open-git-client:open': => @open()

  deactivate: ->
    @subscriptions.dispose()

  open: ->
    editor = atom.workspace.getActivePaneItem()
    path = atom.project.getPaths()[0]

    # command = "cd #{path}&&#{@openCommand}"
    command = "open -a '#{@openCommand}' #{path}"
    exec(command)
