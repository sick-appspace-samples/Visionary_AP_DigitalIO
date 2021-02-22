--[[----------------------------------------------------------------------------

  Application Name: LEDSample
                                                                                                                  
                                                                                             
  Summary:
  Showing basic functionality for using the IO ports.
  
  Description:
  The bidirectional digital ports can be defined as input or output.
  The basics for using the ports are shown in this application.
  Setting a port to as input, setting a port as output and registering a function to a change in the input signal.
  
  How to run:
  Start by running the app (F5) or debugging (F7+F10).
  Set a breakpoint on the first row inside the main function to debug step-by-step.
  See the results in the console.

  ------------------------------------------------------------------------------]]

--luacheck: globals gTimer
--luacheck: globals din_1

local currentDout2State = false

-- Some digital ports are input only, while others are
-- bidirectional. The direction of a bidirectional digital
-- port is set by using different create() methods.

-- Initialize digital in/out 1 to be an input
din_1 = Connector.DigitalIn.create('DI1')

-- Initialize digital in/out 2 to be an output
local dout_2 = Connector.DigitalOut.create('DO2')
dout_2:setPortOutputMode("PUSH_PULL") -- high and low are activley driven by the camera device

-- Add a timer which changes the state of dout_2 once a second
gTimer = Timer.create()
Timer.setPeriodic(gTimer, true)
Timer.setExpirationTime(gTimer, 1000)
Timer.start(gTimer)

-- Toggle the state of dout_2 with every timer expiration
--@toggleDout2State()
local function toggleDout2State()
  currentDout2State = not currentDout2State
  Connector.DigitalOut.set(dout_2, currentDout2State)
  print('Digital Out 2 changed state to ' .. tostring(currentDout2State))
end
Timer.register(gTimer, 'OnExpired', toggleDout2State)

-- To track the changing value of an input, register a callback on
-- the OnChange event of the DI1 port.
--@printDin1State(newState:bool)
local function printDin1State(newState)
  print('Digital I/O 1 changed state to ' .. tostring(newState))
end
Connector.DigitalIn.register(din_1, 'OnChange', printDin1State)
