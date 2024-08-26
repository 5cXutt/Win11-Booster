Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class Kernel32 {
        [DllImport("Kernel32.dll")]
        public static extern bool Beep(int frequency, int duration);
    }
"@

for ($i = 1; $i -le 5; $i++) {
    [void][Kernel32]::Beep(1000, 500)  
    Start-Sleep -Milliseconds 1000    
}
