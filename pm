#!/bin/sh

default_work=25
default_break1=5
default_break2=25
default_iters=4

duration=$1
user=$(id -un)

iter=/tmp/pm-$user-iter
end_time=/tmp/pm-$user-end_time

value() {
    cat $1 2> /dev/null || echo $2
}

set_value() {
    echo $2 > $1
}

incr_value() {
    n=$(value $1 0)
    set_value $1 $((n + 1))
}

sleep_min() {
    min=$1
    now=$(date +%s)
    set_value $end_time $((now + min * 60))
    sleep $((min * 60))
    rm -f $end_time
}

work() {
    if [ -z "$duration" ]; then
        duration=$default_work
    fi
    incr_value $iter
    notify-send "Work $duration min now."
    sleep_min $duration
    notify-send -t 3600000 "Take a break."
}

pause() {
    if [ $(value $iter 0) -eq $default_iters ]; then
        set_value $iter 0
        if [ -z "$duration" ]; then
            duration=$default_break2
        fi
        notify-send "Take a long $duration min break."
    else
        if [ -z "$duration" ]; then
            duration=$default_break1
        fi
        notify-send "Take a short $duration min break."
    fi
    sleep_min $duration
    notify-send -t 3600000 "Get back to work."
}

interrupt() {
    rm -f $iter $end_time
    pkill -u $user 'pm[bw]'
}

time_left() {
    now=$(date +%s)
    end=$(value $end_time -1)
    if [ $end -ge $now ]; then
        diff=$((end - now))
        printf "%d:%02d\n" $((diff / 60)) $((diff % 60))
    else
        exit 1
    fi
}

case $0 in
    *pmw)
        pkill -u $user pmb
        work &
        ;;
    *pmb)
        pkill -u $user pmw
        pause &
        ;;
    *pmi)
        interrupt
        ;;
    *pml)
        time_left
        ;;
esac