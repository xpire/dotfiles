status is-interactive || exit

function __done_grab_wid
   powershell.exe '
Add-Type @"
   using System;
   using System.Runtime.InteropServices;
   public class WindowsCompat {
      [DllImport("user32.dll")]
      public static extern IntPtr GetForegroundWindow();
   }
"@
[WindowsCompat]::GetForegroundWindow()
'
end

set -g __done_initial_wid (__done_grab_wid)
echo "You're window ID is $__done_initial_wid."

function __done_post_callback --on-event fish_prompt
   # only think about sending notif after 5s
   test "$CMD_DURATION" -lt 5000 && return

   # only run if not focussed
   test $__done_initial_wid -eq (__done_grab_wid) && return

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
   
   powershell.exe -command "[void](New-BurntToastNotification -Text '$title')" &

end

