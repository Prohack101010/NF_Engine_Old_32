package;

#if android
import android.content.Context as AndroidContext;
import android.os.Environment as AndroidEnvironment;
import android.Permissions as AndroidPermissions;
import android.Settings as AndroidSettings;
#end

import lime.system.System as LimeSystem;
import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import openfl.utils.Assets as OpenFlAssets;
import openfl.Lib;
import haxe.CallStack.StackItem;
import haxe.CallStack;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import flash.system.System;

/**
 * ...
 * @author: Saw (M.A. Jigsaw)
 */
 
 /*
 KralOyuncu was here
*/

using StringTools;

class SUtil
{
	/**
	 * This returns the external storage path that the game will use by the type.
	 */
	public static function getStorageDirectory(?force:Bool = false):String
	{
		var daPath:String = '';

		#if android
		if (!FileSystem.exists(LimeSystem.applicationStorageDirectory + 'storagetype.txt'))
			File.saveContent(LimeSystem.applicationStorageDirectory + 'storagetype.txt', ClientPrefs.storageType);
		var curStorageType:String = File.getContent(LimeSystem.applicationStorageDirectory + 'storagetype.txt');
		daPath = force ? StorageType.fromStrForce(curStorageType) : StorageType.fromStr(curStorageType);
		daPath = haxe.io.Path.addTrailingSlash(daPath);
		#elseif ios
		daPath = LimeSystem.documentsDirectory;
		#end

		return daPath;
	}
	
	public static function mkDirs(directory:String):Void
	{
		var total:String = '';
		if (directory.substr(0, 1) == '/')
			total = '/';

		var parts:Array<String> = directory.split('/');
		if (parts.length > 0 && parts[0].indexOf(':') > -1)
			parts.shift();

		for (part in parts)
		{
			if (part != '.' && part != '')
			{
				if (total != '' && total != '/')
					total += '/';

				total += part;

				try
				{
					if (!FileSystem.exists(total))
						FileSystem.createDirectory(total);
				}
				catch (e:haxe.Exception)
					trace('Error while creating folder. (${e.message}');
			}
		}
	}
	
	public static function saveContent(fileName:String = 'file', fileExtension:String = '.json',
			fileData:String = 'You forgor to add somethin\' in yo code :3'):Void
	{
		try
		{
			if (!FileSystem.exists('saves'))
				FileSystem.createDirectory('saves');

			File.saveContent('saves/' + fileName + fileExtension, fileData);
			SUtil.applicationAlert("Success!", fileName + " file has been saved.");
		}
		catch (e:haxe.Exception)
			trace('File couldn\'t be saved. (${e.message})');
	}
	
	#if android
	public static function doPermissionsShit():Void
	{
		if (!AndroidPermissions.getGrantedPermissions().contains('android.permission.READ_EXTERNAL_STORAGE')
			&& !AndroidPermissions.getGrantedPermissions().contains('android.permission.WRITE_EXTERNAL_STORAGE'))
		{
			AndroidPermissions.requestPermission('READ_EXTERNAL_STORAGE');
			AndroidPermissions.requestPermission('WRITE_EXTERNAL_STORAGE');
			SUtil.applicationAlert('Notice!',
				'If you accepted the permissions you are all good!' + '\nIf you didn\'t then expect a crash' + '\nPress Ok to see what happens');
			if (!AndroidEnvironment.isExternalStorageManager())
				AndroidSettings.requestSetting('MANAGE_APP_ALL_FILES_ACCESS_PERMISSION');
		}
		else
		{
			try
			{
				if (!FileSystem.exists(SUtil.getStorageDirectory()))
					FileSystem.createDirectory(SUtil.getStorageDirectory());
			}
			catch (e:Dynamic)
			{
				SUtil.applicationAlert('Error!', 'Please create folder to\n' + SUtil.getStorageDirectory(true) + '\nPress OK to close the game');
				LimeSystem.exit(1);
			}
		}
	}
	#end

    /*
    #if android
	public static function doTheCheck():Void
	{
		if (!AndroidPermissions.getGrantedPermissions().contains(AndroidPermissions.READ_EXTERNAL_STORAGE)
			&& !AndroidPermissions.getGrantedPermissions().contains(AndroidPermissions.WRITE_EXTERNAL_STORAGE))
		{
			AndroidPermissions.requestPermission(AndroidPermissions.READ_EXTERNAL_STORAGE);
			AndroidPermissions.requestPermission(AndroidPermissions.WRITE_EXTERNAL_STORAGE);
			SUtil.applicationAlert('Notice!',
				'If you accepted the permissions you are all good!' + '\nIf you didn\'t then expect a crash' + '\nPress Ok to see what happens');
			if (!AndroidEnvironment.isExternalStorageManager())
				AndroidSettings.requestSetting("android.settings.MANAGE_APP_ALL_FILES_ACCESS_PERMISSION");
		}
		else
		{
			try
			{
				if (!FileSystem.exists(SUtil.getStorageDirectory()))
					FileSystem.createDirectory(SUtil.getStorageDirectory());
			}
			catch (e:Dynamic)
			{
				SUtil.applicationAlert("Error!", "Please create folder to\n" + SUtil.getStorageDirectory(true) + "\nPress OK to close the game");
				LimeSystem.exit(1);
			}
		}
	}
	#end
	*/
	
	public static function SUtil.applicationAlert(title:String, message:String):Void
	{
		#if (windows || android || js || wasm)
		Lib.application.window.alert(message, title);
		#else
		LimeLogger.println('$title - $message');
		#end
	}
	
	/*
	public static function SUtil.applicationAlert(title:String, message:String #if android, ?positiveText:String = "OK", ?positiveFunc:Void->Void #end):Void
	{
		#if android
		AndroidTools.showAlertDialog(title, message, {name: positiveText, func: positiveFunc}, null);
		#elseif (windows || web)
		openfl.Lib.application.window.alert(message, title);
		#else
		LimeLogger.println('$title - $message');
		#end
	}
	*/

	public static function gameCrashCheck()
	{
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
	}

	public static function onCrash(e:UncaughtErrorEvent):Void
	{
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();
		dateNow = StringTools.replace(dateNow, " ", "_");
		dateNow = StringTools.replace(dateNow, ":", "'");

		var path:String = "crash/" + "crash_" + dateNow + ".txt";
		var errMsg:String = "";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += e.error;

		if (!FileSystem.exists("crash"))
		FileSystem.createDirectory("crash");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));
		Sys.println("Making a simple alert ...");

		SUtil.applicationAlert(errMsg, "Uncaught Error :(!");
		System.exit(0);
	}

	#if android
    public static function AutosaveContent(fileName:String = 'file', fileExtension:String = '.json', fileData:String = 'you forgot something to add in your code')
	{
		if (!FileSystem.exists('saves'))
			FileSystem.createDirectory('saves');

		File.saveContent('saves/' + fileName + fileExtension, fileData);
		//SUtil.applicationAlert('Done :)!', 'File Saved Successfully!');
	}
	
	public static function saveClipboard(fileData:String = 'you forgot something to add in your code')
	{
		openfl.system.System.setClipboard(fileData);
		SUtil.applicationAlert('Done :)!', 'Data Saved to Clipboard Successfully!');
	}

	public static function copyContent(copyPath:String, savePath:String)
	{
		if (!FileSystem.exists(savePath))
			File.saveBytes(savePath, OpenFlAssets.getBytes(copyPath));
	}
	#end
} 

#if android
enum abstract StorageType(String) from String to String
{
	final forcedPath = '/storage/emulated/0/';
	final packageNameLocal = 'com.NFengine063test';
	final fileLocal = 'NF Engine';
	final fileLocal2 = 'NovaFlare Engine';
	final fileLocal3 = 'PsychEngine';
	//AndroidEnvironment.getExternalStorageDirectory() + '/Android/data/' + Application.current.meta.get('packageName') + '/'

	public static function fromStr(str:String):StorageType
	{
	    final OBB = AndroidContext.getObbDir();
		final MEDIA = AndroidEnvironment.getExternalStorageDirectory() + '/Android/media/' + Application.current.meta.get('packageName');
		final PSYCH_ENGINE = forcedPath + '.' + fileLocal3;
		final NOVAFLARE = forcedPath + '.' + fileLocal2;
		final NF_ENGINE = forcedPath + '.' + fileLocal;

		return switch (str)
		{
		    case "OBB": OBB;
			case "MEDIA": MEDIA;
			case "PSYCH_ENGINE": PSYCH_ENGINE;
			case "NOVAFLARE": NOVAFLARE;
			case "NF_ENGINE": NF_ENGINE;
			default: NF_ENGINE;
		}
	}

	public static function fromStrForce(str:String):StorageType
	{
	    final OBB = forcedPath + 'Android/obb/' + packageNameLocal;
		final MEDIA = forcedPath + 'Android/media/' + packageNameLocal;
		final PSYCH_ENGINE = forcedPath + '.' + fileLocal3;
		final NOVAFLARE = forcedPath + '.' + fileLocal2;
		final NF_ENGINE = forcedPath + '.' + fileLocal;

		return switch (str)
		{
		    case "OBB": OBB;
			case "MEDIA": MEDIA;
			case "PSYCH_ENGINE": PSYCH_ENGINE;
			case "NOVAFLARE": NOVAFLARE;
			case "NF_ENGINE": NF_ENGINE;
			default: NF_ENGINE;
		}
	}
}
#end