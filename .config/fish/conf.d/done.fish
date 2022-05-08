status is-interactive || exit

function _done_callback --on-event fish_prompt
   echo "_done_callback called" 

   # only think about sending notif after 30 seconds
   test "$CMD_DURATION" -lt 30000 && set _hydro_cmd_duration && return

   # get command duration
   set --local humanised_seconds ""

   set --local secs (math --scale=1 $CMD_DURATION/1000 % 60)
   set --local mins (math --scale=0 $CMD_DURATION/60000 % 60)
   set --local hours (math --scale=0 $CMD_DURATION/3600000)

   test $hours -gt 0 && set --local --append humanised_seconds $hours"h"
   test $mins -gt 0 && set --local --append humanised_seconds $mins"m"
   test $secs -gt 0 && set --local --append humanised_seconds $secs"s"

   set -l title "Done in$humanised_seconds"
   if test $status -ne 0
      set title "Failed ($status) after$humanised_seconds"
   end
   
   echo "$title"

   powershell.exe -command New-BurntToastNotification -Text "$title"

end

