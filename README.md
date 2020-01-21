Simple shell script for Pomodoro time management technique. Provides a
set of shell commands.

# Commands

## `tomnext [minutes]`

Do the next reasonable thing with the timer:

- set the pomodoro timer for work (default to 25 minutes).
- set the timer for a break (default to either 5 or 25 minutes,
  depending on the number of complete work intervals).
- print time left until the timer rings, if it's already set.

## `tomleft`

Print time left until the timer rings.

## `tomreset`

Stop the timer and reset work intervals counting.

# Dependencies

Uses `notify-send` and `canberra-gtk-play` commands for notifications
(provided by `libnotify-bin` and `gnome-session-canberra` packages in
Debian).

# Configuration

The following environment variables may be used to configure the script:

- `TOM_WORK_DUR` — work time duration in minutes.
- `TOM_SHORT_BREAK_DUR` — short break duration in minutes.
- `TOM_LONG_BREAK_DUR` — long break duration in minutes.
- `TOM_ITERS_MULT` — number of complete work intervals before a longer
  break.
