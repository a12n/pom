Simple shell script for Pomodoro time management technique. Provides a
set of shell commands.

# Commands

## `pomwork [minutes]`

Set the pomodoro timer (default to 25 minutes).

## `pombreak [minutes]`

Set the timer for a break (default to either 5 or 25 minutes,
depending on the number of complete work intervals).

## `pomleft`

Print time left until the timer rings.

## `pomintrpt`

Stop the timer and reset work intervals counting.

# Dependencies

Uses `notify-send` and `play` commands for notifications (provided by
`libnotify-bin` and `sox` packages in Debian).

# Configuration

`POM_SOUND_FILE` may be set to an audio file path to be played for
notification. Set to `/dev/null` if you don't want any sounds.
