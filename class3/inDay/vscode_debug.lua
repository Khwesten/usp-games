json = require 'debug/dkjson'
debuggee = require 'debug/vscode-debuggee'
startResult, breakerType = debuggee.start(json)

print('debuggee start ->', startResult, breakerType)

xpcall(
  function()
    -- Code to actually run
    local a = 1 + nil
  end,
  function(e)
    if debuggee.enterDebugLoop(1, e) then
      -- ok
    else
      -- If the debugger is not attached, enter here.
      print(e)
      print(debug.traceback())
    end
  end
)