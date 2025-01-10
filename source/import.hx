import Paths;

//Mobile Things
import mobile.backend.*;
import android.*;
import android.flixel.*;
import android.FlxVirtualPad;

#if sys
import sys.*;
import sys.io.*;
#elseif js
import js.html.*;
#end

// Android
#if android
import android.Tools as AndroidTools;
import android.Settings as AndroidSettings;
import android.widget.Toast as AndroidToast;
import android.content.Context as AndroidContext;
import android.Permissions as AndroidPermissions;
import android.os.Build.VERSION as AndroidVersion;
import android.os.Environment as AndroidEnvironment;
import android.os.BatteryManager as AndroidBatteryManager;
import android.os.Build.VERSION_CODES as AndroidVersionCode;
#end

using StringTools;