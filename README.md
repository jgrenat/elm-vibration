# elm-vibration

##Examples
To vibrate for 200 milliseconds:

    vibrate (200 * millisecond)
    
To vibrate for 200 ms, then pause for 300 ms, then vibrate again for 400 ms:

    vibrateInPattern [200 * millisecond, 300 * millisecond, 400 * millisecond]

To stop any current vibration:

    cancel
