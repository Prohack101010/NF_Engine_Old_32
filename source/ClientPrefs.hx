package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

class ClientPrefs {
    #if mobile
    //Mobile Things
	public static var wideScreen:Bool = false;
	#if android
	public static var storageType:String = "EXTERNAL_DATA";
	#end
	public static var VirtualPadSkin:String = 'original';
	public static var virtualpadType:String = "New";
	public static var VirtualPadAlpha:Float = #if mobile 0.6 #else 0 #end;
	public static var extraKeyReturn1:String = 'SHIFT';
    public static var extraKeyReturn2:String = 'SPACE';
    public static var extraKeyReturn3:String = 'Q';
    public static var extraKeyReturn4:String = 'E';
	public static var hitboxhint:Bool = false;
	public static var hitboxmode:String = 'New';  //starting new way to change between hitboxes yay
	public static var hitboxtype:String = 'Gradient';
	public static var extraKeys:Int = 2;
	public static var hitboxLocation:String = 'Bottom';
	public static var hitboxalpha:Float = #if mobile 0.7 #else 0 #end; //someone request this lol
	public static var coloredvpad:Bool = true;
	#end

    //Psych Engine
	public static var downScroll:Bool = true;
	public static var middleScroll:Bool = true;
	public static var betterMidScroll:Bool = false;
	public static var opponentStrums:Bool = true;
	public static var showFPS:Bool = false;
	public static var flashing:Bool = true;
	public static var globalAntialiasing:Bool = true;
	public static var noteSplashes:Bool = true;
	public static var lowQuality:Bool = false;
	public static var shaders:Bool = true;
	public static var framerate:Int = 60;
	
	public static var cursing:Bool = true;
	public static var violence:Bool = true;
	public static var camZooms:Bool = true;
	public static var doubleGhost:Bool = true;
	public static var hideHud:Bool = false;
	public static var noteOffset:Int = 0;
	public static var arrowHSV:Array<Array<Int>> = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]];
	public static var vibration:Bool = false;
	public static var ghostTapping:Bool = true;
	public static var hudType:String = 'Kade Engine';
	public static var splashType:String = 'Psych Engine';
	public static var timeBarType:String = 'Time Left';
	public static var opponentLightStrum:Bool = true;
	public static var botLightStrum:Bool = true;
	public static var scoreZoom:Bool = true;
	public static var noReset:Bool = false;
	public static var healthBarAlpha:Float = 1;
	public static var oppNoteAlpha:Float = 0.65;
	public static var controllerMode:Bool = #if mobile true #else false #end;
	public static var hitsoundVolume:Float = 0;
	public static var misssoundVolume:Float = 0;
	public static var pauseMusic:String = 'Tea Time';
	public static var checkForUpdates:Bool = true;
	public static var comboStacking = true;
	public static var charsAndBG:Bool = true;
	public static var fasterChartLoad:Bool = false;
	public static var showComboNum = true;
	public static var showRating = true;
    
    public static var fixopponentplay = true;
    public static var ezSpam:Bool = false;
    //public static var extramenu:Bool = false;
    public static var dynamicSpawnTime:Bool = false;
    public static var noteSpawnTime:Float = 1;
	public static var gameplaySettings:Map<String, Dynamic> = [
		'scrollspeed' => 1.0,
		'scrolltype' => 'multiplicative', 
		// anyone reading this, amod is multiplicative speed mod, cmod is constant speed mod, and xmod is bpm based speed mod.
		// an amod example would be chartSpeed * multiplier
		// cmod would just be constantSpeed = chartSpeed
		// and xmod basically works by basing the speed on the bpm.
		// iirc (beatsPerSecond * (conductorToNoteDifference / 1000)) * noteSize (110 or something like that depending on it, prolly just use note.height)
		// bps is calculated by bpm / 60
		// oh yeah and you'd have to actually convert the difference to seconds which I already do, because this is based on beats and stuff. but it should work
		// just fine. but I wont implement it because I don't know how you handle sustains and other stuff like that.
		// oh yeah when you calculate the bps divide it by the songSpeed or rate because it wont scroll correctly when speeds exist.
		'songspeed' => 1.0,
		'healthgain' => 1.0,
		'healthloss' => 1.0,
		'instakill' => false,
		'practice' => true,
		'botplay' => false,
		'opponentplay' => false,
		'opponentdrain' => false,
		'drainlevel' => 1,
		'randomspeed' => false,
		'thetrollingever' => false
	];

	public static var comboOffset:Array<Int> = [0, 0, 0, 0];
	public static var ratingOffset:Int = 0;
	public static var marvelousWindow:Int = 15;
	public static var sickWindow:Int = 45;
	public static var goodWindow:Int = 90;
	public static var badWindow:Int = 135;
	public static var safeFrames:Float = 10;

	//Every key has two binds, add your key bind down here and then add your control on options/ControlsSubState.hx and Controls.hx
	public static var keyBinds:Map<String, Array<FlxKey>> = [
		//Key Bind, Name for ControlsSubState
		'note_left'		=> [A, LEFT],
		'note_down'		=> [S, DOWN],
		'note_up'		=> [W, UP],
		'note_right'	=> [D, RIGHT],
		
		'ui_left'		=> [A, LEFT],
		'ui_down'		=> [S, DOWN],
		'ui_up'			=> [W, UP],
		'ui_right'		=> [D, RIGHT],
		
		'accept'		=> [SPACE, ENTER],
		'back'			=> [BACKSPACE, ESCAPE],
		'pause'			=> [ENTER, ESCAPE],
		'reset'			=> [R, NONE],
		
		'volume_mute'	=> [ZERO, NONE],
		'volume_up'		=> [NUMPADPLUS, PLUS],
		'volume_down'	=> [NUMPADMINUS, MINUS],
		
		'debug_1'		=> [SEVEN, NONE],
		'debug_2'		=> [EIGHT, NONE]
	];
	
	// new extend
	public static var rainbowFPS:Bool = true;
	
	public static var gradientTimeBar:Bool = true;
	public static var filpChart:Bool = false;
	
	public static var NoteSkin:String = 'original';

	// new extend
	public static var defaultKeys:Map<String, Array<FlxKey>> = null;

	public static function loadDefaultKeys() {
		defaultKeys = keyBinds.copy();
		//trace(defaultKeys);
	}

	public static function saveSettings() {
	    #if mobile
	    //Mobile Things
		FlxG.save.data.wideScreen = wideScreen;
		FlxG.save.data.VirtualPadSkin = VirtualPadSkin;
		FlxG.save.data.virtualpadType = virtualpadType;
		FlxG.save.data.VirtualPadAlpha = VirtualPadAlpha;
		FlxG.save.data.extraKeyReturn1 = extraKeyReturn1;
		FlxG.save.data.extraKeyReturn2 = extraKeyReturn2;
		FlxG.save.data.extraKeyReturn3 = extraKeyReturn3;
		FlxG.save.data.extraKeyReturn4 = extraKeyReturn4;
		FlxG.save.data.hitboxhint = hitboxhint;
		FlxG.save.data.hitboxmode = hitboxmode;
		FlxG.save.data.hitboxtype = hitboxtype;
		FlxG.save.data.extraKeys = extraKeys;
		FlxG.save.data.hitboxLocation = hitboxLocation;
		FlxG.save.data.hitboxalpha = hitboxalpha;
		FlxG.save.data.coloredvpad = coloredvpad;
		FlxG.save.data.storageType = storageType;
		#ene
		
		//Psych Engine
		FlxG.save.data.downScroll = downScroll;
		FlxG.save.data.middleScroll = middleScroll;
		FlxG.save.data.betterMidScroll = betterMidScroll;
		FlxG.save.data.opponentStrums = opponentStrums;
		FlxG.save.data.showFPS = showFPS;
		FlxG.save.data.flashing = flashing;
		FlxG.save.data.globalAntialiasing = globalAntialiasing;
		FlxG.save.data.noteSplashes = noteSplashes;
		FlxG.save.data.lowQuality = lowQuality;
		FlxG.save.data.shaders = shaders;
		FlxG.save.data.framerate = framerate;
		FlxG.save.data.rainbowFPS = rainbowFPS;
		FlxG.save.data.gradientTimeBar = gradientTimeBar;
		FlxG.save.data.dynamicSpawnTime = dynamicSpawnTime;
		FlxG.save.data.noteSpawnTime = noteSpawnTime;
		FlxG.save.data.camZooms = camZooms;
		FlxG.save.data.doubleGhost = doubleGhost;
		FlxG.save.data.noteOffset = noteOffset;
		FlxG.save.data.hideHud = hideHud;
		FlxG.save.data.arrowHSV = arrowHSV;
		FlxG.save.data.vibration = vibration;
		FlxG.save.data.ghostTapping = ghostTapping;
		FlxG.save.data.timeBarType = timeBarType;
		FlxG.save.data.splashType = splashType;
		FlxG.save.data.scoreZoom = scoreZoom;
		FlxG.save.data.noReset = noReset;
		FlxG.save.data.healthBarAlpha = healthBarAlpha;
		FlxG.save.data.comboOffset = comboOffset;
		FlxG.save.data.achievementsMap = Achievements.achievementsMap;
		FlxG.save.data.henchmenDeath = Achievements.henchmenDeath;

		FlxG.save.data.ratingOffset = ratingOffset;
		FlxG.save.data.marvelousWindow = marvelousWindow;
		FlxG.save.data.sickWindow = sickWindow;
		FlxG.save.data.goodWindow = goodWindow;
		FlxG.save.data.badWindow = badWindow;
		FlxG.save.data.safeFrames = safeFrames;
		FlxG.save.data.gameplaySettings = gameplaySettings;
		FlxG.save.data.controllerMode = controllerMode;
		FlxG.save.data.hitsoundVolume = hitsoundVolume;
		FlxG.save.data.misssoundVolume = misssoundVolume;
		FlxG.save.data.pauseMusic = pauseMusic;
		FlxG.save.data.checkForUpdates = checkForUpdates;
		FlxG.save.data.comboStacking = comboStacking;
		FlxG.save.data.showRating = showRating;
		FlxG.save.data.showComboNum = showComboNum;
		FlxG.save.data.charsAndBG = charsAndBG;
		FlxG.save.data.fasterChartLoad = fasterChartLoad;
	        
	    FlxG.save.data.botLightStrum = botLightStrum;
		FlxG.save.data.opponentLightStrum = opponentLightStrum;
		FlxG.save.data.oppNoteAlpha = oppNoteAlpha;
	    FlxG.save.data.hudType = hudType;
	    FlxG.save.data.fixopponentplay = fixopponentplay;
	    FlxG.save.data.ezSpam = ezSpam;
	    FlxG.save.data.NoteSkin = NoteSkin;
	    FlxG.save.data.filpChart = filpChart;
	    // new extend
		FlxG.save.flush();

		var save:FlxSave = new FlxSave();
		save.bind('controls_v2' , CoolUtil.getSavePath()); //Placing this in a separate save so that it can be manually deleted without removing your Score and stuff
		save.data.customControls = keyBinds;
		save.flush();
		FlxG.log.add("Settings saved!");
	}

	public static function loadPrefs() {
	    #if mobile
	    if(FlxG.save.data.storageType != null)
			storageType = FlxG.save.data.storageType;
	    if(FlxG.save.data.wideScreen != null)
			wideScreen = FlxG.save.data.wideScreen;
	    if(FlxG.save.data.VirtualPadSkin != null)
			VirtualPadSkin = FlxG.save.data.VirtualPadSkin;
	    if(FlxG.save.data.virtualpadType != null)
			virtualpadType = FlxG.save.data.virtualpadType;
	    if(FlxG.save.data.VirtualPadAlpha != null)
			VirtualPadAlpha = FlxG.save.data.VirtualPadAlpha;
	    if(FlxG.save.data.extraKeyReturn1 != null)
			extraKeyReturn1 = FlxG.save.data.extraKeyReturn1;
	    if(FlxG.save.data.extraKeyReturn2 != null)
			extraKeyReturn2 = FlxG.save.data.extraKeyReturn2;
	    if(FlxG.save.data.extraKeyReturn3 != null)
			extraKeyReturn3 = FlxG.save.data.extraKeyReturn3;
	    if(FlxG.save.data.extraKeyReturn4 != null)
			extraKeyReturn4 = FlxG.save.data.extraKeyReturn4;
	    if(FlxG.save.data.hitboxhint != null)
			hitboxhint = FlxG.save.data.hitboxhint;
	    if(FlxG.save.data.hitboxmode != null)
			hitboxmode = FlxG.save.data.hitboxmode;
	    if(FlxG.save.data.hitboxtype != null)
			hitboxtype = FlxG.save.data.hitboxtype;
	    if(FlxG.save.data.extraKeys != null)
			extraKeys = FlxG.save.data.extraKeys;
	    if(FlxG.save.data.hitboxLocation != null)
			hitboxLocation = FlxG.save.data.hitboxLocation;
	    if(FlxG.save.data.hitboxalpha != null)
			hitboxalpha = FlxG.save.data.hitboxalpha;
	    if(FlxG.save.data.coloredvpad != null)
			coloredvpad = FlxG.save.data.coloredvpad;
		#end
		
		if(FlxG.save.data.downScroll != null)
			downScroll = FlxG.save.data.downScroll;
		if(FlxG.save.data.middleScroll != null)
			middleScroll = FlxG.save.data.middleScroll;
		if(FlxG.save.data.betterMidScroll != null)
			betterMidScroll = FlxG.save.data.betterMidScroll;
		if(FlxG.save.data.opponentStrums != null)
			opponentStrums = FlxG.save.data.opponentStrums;
		if(FlxG.save.data.showFPS != null) {
			showFPS = FlxG.save.data.showFPS;
			if(Main.fpsVar != null)
				Main.fpsVar.visible = showFPS;
		}
		if(FlxG.save.data.flashing != null)
			flashing = FlxG.save.data.flashing;
		if(FlxG.save.data.globalAntialiasing != null)
			globalAntialiasing = FlxG.save.data.globalAntialiasing;
		if(FlxG.save.data.noteSplashes != null)
			noteSplashes = FlxG.save.data.noteSplashes;
		if(FlxG.save.data.lowQuality != null)
			lowQuality = FlxG.save.data.lowQuality;
		if(FlxG.save.data.shaders != null)
			shaders = FlxG.save.data.shaders;
		if(FlxG.save.data.framerate != null) {
			framerate = FlxG.save.data.framerate;
			if(framerate > FlxG.drawFramerate) {
				FlxG.updateFramerate = framerate;
				FlxG.drawFramerate = framerate;
			} else {
				FlxG.drawFramerate = framerate;
				FlxG.updateFramerate = framerate;
			}
		}
		
		if(FlxG.save.data.camZooms != null)
			camZooms = FlxG.save.data.camZooms;
		if(FlxG.save.data.doubleGhost != null)
			doubleGhost = FlxG.save.data.doubleGhost;
		if(FlxG.save.data.hideHud != null)
			hideHud = FlxG.save.data.hideHud;
		if(FlxG.save.data.fasterChartLoad != null)
			fasterChartLoad = FlxG.save.data.fasterChartLoad;
		if(FlxG.save.data.noteOffset != null)
			noteOffset = FlxG.save.data.noteOffset;
		if(FlxG.save.data.arrowHSV != null)
			arrowHSV = FlxG.save.data.arrowHSV;
		if(FlxG.save.data.vibration != null)
			vibration = FlxG.save.data.vibration;
		if(FlxG.save.data.ghostTapping != null)
			ghostTapping = FlxG.save.data.ghostTapping;
		if(FlxG.save.data.timeBarType != null)
			timeBarType = FlxG.save.data.timeBarType;
		if(FlxG.save.data.splashType != null)
			splashType = FlxG.save.data.splashType;
		if(FlxG.save.data.noteSpawnTime != null)
			noteSpawnTime = FlxG.save.data.noteSpawnTime;
		if(FlxG.save.data.dynamicSpawnTime != null)
			dynamicSpawnTime = FlxG.save.data.dynamicSpawnTime;
		if(FlxG.save.data.scoreZoom != null)
			scoreZoom = FlxG.save.data.scoreZoom;
		if(FlxG.save.data.charsAndBG != null)
			charsAndBG = FlxG.save.data.charsAndBG;
		if(FlxG.save.data.noReset != null)
			noReset = FlxG.save.data.noReset;
		if(FlxG.save.data.healthBarAlpha != null)
			healthBarAlpha = FlxG.save.data.healthBarAlpha;
		if(FlxG.save.data.comboOffset != null)
			comboOffset = FlxG.save.data.comboOffset;
		if(FlxG.save.data.ratingOffset != null)
			ratingOffset = FlxG.save.data.ratingOffset;
		if(FlxG.save.data.marvelousWindow != null)
			marvelousWindow = FlxG.save.data.marvelousWindow;
		if(FlxG.save.data.sickWindow != null)
			sickWindow = FlxG.save.data.sickWindow;
		if(FlxG.save.data.goodWindow != null)
			goodWindow = FlxG.save.data.goodWindow;
		if(FlxG.save.data.badWindow != null)
			badWindow = FlxG.save.data.badWindow;
		if(FlxG.save.data.safeFrames != null)
			safeFrames = FlxG.save.data.safeFrames;
		if(FlxG.save.data.controllerMode != null)
			controllerMode = FlxG.save.data.controllerMode;
		if(FlxG.save.data.hitsoundVolume != null)
			hitsoundVolume = FlxG.save.data.hitsoundVolume;
		if(FlxG.save.data.misssoundVolume != null)
			misssoundVolume = FlxG.save.data.misssoundVolume;
		if(FlxG.save.data.oppNoteAlpha != null)
			oppNoteAlpha = FlxG.save.data.oppNoteAlpha;
		if(FlxG.save.data.hudType != null)
			hudType = FlxG.save.data.hudType;
		if(FlxG.save.data.fixopponentplay != null)
			fixopponentplay = FlxG.save.data.fixopponentplay;
		if(FlxG.save.data.ezSpam != null)
			ezSpam = FlxG.save.data.ezSpam;
		if(FlxG.save.data.botLightStrum != null)
			botLightStrum = FlxG.save.data.botLightStrum;
		if(FlxG.save.data.opponentLightStrum != null)
			opponentLightStrum = FlxG.save.data.opponentLightStrum;
		if(FlxG.save.data.pauseMusic != null)
			pauseMusic = FlxG.save.data.pauseMusic;
		if(FlxG.save.data.gameplaySettings != null)
		{
			var savedMap:Map<String, Dynamic> = FlxG.save.data.gameplaySettings;
			for (name => value in savedMap)
			{
				gameplaySettings.set(name, value);
			}
		}
		
		// new extend
		if(FlxG.save.data.rainbowFPS != null)
			rainbowFPS = FlxG.save.data.rainbowFPS;
		if(FlxG.save.data.gradientTimeBar != null)
			gradientTimeBar = FlxG.save.data.gradientTimeBar;
		if(FlxG.save.data.NoteSkin != null)
			NoteSkin = FlxG.save.data.NoteSkin;

		if(FlxG.save.data.filpChart != null)
			filpChart = FlxG.save.data.filpChart;		
		// new extend
		// flixel automatically saves your volume!
		if(FlxG.save.data.volume != null)
			FlxG.sound.volume = FlxG.save.data.volume;
		if (FlxG.save.data.mute != null)
			FlxG.sound.muted = FlxG.save.data.mute;
		if (FlxG.save.data.checkForUpdates != null)
			checkForUpdates = FlxG.save.data.checkForUpdates;
		if (FlxG.save.data.comboStacking != null)
			comboStacking = FlxG.save.data.comboStacking;
		if (FlxG.save.data.showRating != null)
			showRating = FlxG.save.data.showRating;
		if (FlxG.save.data.showComboNum != null)
			showComboNum = FlxG.save.data.showComboNum;		
			

		var save:FlxSave = new FlxSave();
		save.bind('controls_v2' , CoolUtil.getSavePath());
		if(save != null && save.data.customControls != null) {
			var loadedControls:Map<String, Array<FlxKey>> = save.data.customControls;
			for (control => keys in loadedControls) {
				keyBinds.set(control, keys);
			}
			reloadControls();
		}
	}

	inline public static function getGameplaySetting(name:String, defaultValue:Dynamic):Dynamic {
		return /*PlayState.isStoryMode ? defaultValue : */ (gameplaySettings.exists(name) ? gameplaySettings.get(name) : defaultValue);
	}

	public static function reloadControls() {
		PlayerSettings.player1.controls.setKeyboardScheme(KeyboardScheme.Solo);

		TitleState.muteKeys = copyKey(keyBinds.get('volume_mute'));
		TitleState.volumeDownKeys = copyKey(keyBinds.get('volume_down'));
		TitleState.volumeUpKeys = copyKey(keyBinds.get('volume_up'));
		FlxG.sound.muteKeys = TitleState.muteKeys;
		FlxG.sound.volumeDownKeys = TitleState.volumeDownKeys;
		FlxG.sound.volumeUpKeys = TitleState.volumeUpKeys;
	}
	public static function copyKey(arrayToCopy:Array<FlxKey>):Array<FlxKey> {
		var copiedArray:Array<FlxKey> = arrayToCopy.copy();
		var i:Int = 0;
		var len:Int = copiedArray.length;

		while (i < len) {
			if(copiedArray[i] == NONE) {
				copiedArray.remove(NONE);
				--i;
			}
			i++;
			len = copiedArray.length;
		}
		return copiedArray;
	}
}
