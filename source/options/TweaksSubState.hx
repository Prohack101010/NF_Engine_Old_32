package options;

#if desktop
import Discord.DiscordClient;
#end
import lime.system.System;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import haxe.Json;
import haxe.format.JsonParser;
import Controls;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import lime.app.Application;

using StringTools;

class TweaksSubState extends BaseOptionsMenu
{
    var noteSkinList:Array<String> = CoolUtil.coolTextFile(Paths.getPreloadPath('images/NoteSkin/DataSet/noteSkinList.txt'));
        
	public function new()
	{
		title = 'NF Engine Tweaks Menu';
		rpcTitle = 'KralOyuncu & NF Engine Tweaks Menu'; //for Discord Rich Presence
        noteSkinList.unshift('original');
        
		var option:Option = new Option('HUD Type:',
			"Which HUD would you like?",
			'hudType',
			'string',
			'Psych Engine',
			['VS Impostor', 'Kade Engine', 'Dave & Bambi', 'Psych Engine']);
		addOption(option);
		
		
		var option:Option = new Option('Note Skin',
			"Choose Note Skin",
			'NoteSkin',
			'string',
			'original',
			noteSkinList);
			
		option.showNote = true;
		addOption(option);
		option.onChange = onChangeNoteSkin;
		
		var option:Option = new Option('Note Splash Type:',
			"Which note splash would you like?",
			'splashType',
			'string',
			'Psych Engine',
			['Psych Engine', 'VS Impostor', 'Base Game', 'Doki Doki+', 'TGT V4', 'Indie Cross']);
		addOption(option);
		
		var option:Option = new Option('Spammable Inputs',
			'If chacked the input system is more spammable',
			'ezSpam',
			'bool',
			true);
		addOption(option);
		
		var option:Option = new Option('GradientColor TimeBar ',
			"If chacked timebar will have gradient color\nbut maybe will have bug when you change timebar color again",
			'gradientTimeBar',
			'bool',
			true);
		addOption(option);
		
		/* I can add this very soon
		var option:Option = new Option('Enable Extra Menu Buttons',
			"Credits & Mods",
			'extramenu',
			'bool',
			false);
		addOption(option);
		*/
		
		var option:Option = new Option('Better Middlescroll',
			"If chacked your notes and the opponent's notes get centered",
			'betterMidScroll',
			'bool',
			false);
		addOption(option);
		
		var option:Option = new Option('Opponent Note Transparency: ',
			"How visible do you want the opponent's notes to be when Middlescroll is enabled? \n(0% = invisible, 100% = fully visible)",
			'oppNoteAlpha',
			'percent',
			0.65);
		option.scrollSpeed = 1.8;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.01;
		option.decimals = 2;
		addOption(option);
		
		var option:Option = new Option('Light Opponent Strums',
			"If this is unchecked, the Opponent strums won't light up when the Opponent hits a note",
			'opponentLightStrum',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Light Botplay Strums',
			"If this is unchecked, the Player strums won't light when Botplay is active",
			'botLightStrum',
			'bool',
			true);
		addOption(option);
		
		var option:Option = new Option('Automatic Note Spawn Time', //Name
			"If checked, the Notes' spawn time will instead depend on the scroll speed. \nUseful if you don't want notes just spawning out of thin air. \nNOTE: Disable this if you use Lua Extra Keys!!", //Description
			'dynamicSpawnTime', //Save data variable name
			'bool', //Variable type
			true); //Default value
		addOption(option);
		
		var option:Option = new Option('Fix Opponent Play Mechanics',
			'Just Mechanics Bro',
			'fixopponentplay',
			'bool',
			true);
		addOption(option);
		
		var option:Option = new Option('Chars & BG',
			'If unchecked, gameplay will only show the HUD (STILL WIP)',
			'charsAndBG',
			'bool',
			true);
		addOption(option);
		
		var option:Option = new Option('Optimized Chart Loading',
			'If checked, hopefully tries to get charts to load faster.',
			'fasterChartLoad',
			'bool',
			false);
		addOption(option);

		super();
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)));

		changedMusic = true;
	}

	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showFPS;
	}
	
	function onChangeNoteSkin()
	{
        remove(grpNote);
		
		grpNote = new FlxTypedGroup<FlxSprite>();
		add(grpNote);
		
		for (i in 0...ClientPrefs.arrowHSV.length) {
			var notes:FlxSprite = new FlxSprite((i * 125), 100);
			if (ClientPrefs.NoteSkin != 'original') notes.frames = Paths.getSparrowAtlas('NoteSkin/' + ClientPrefs.NoteSkin);   
			else notes.frames = Paths.getSparrowAtlas('NOTE_assets');
			
			var animations:Array<String> = ['purple0', 'blue0', 'green0', 'red0'];
			notes.animation.addByPrefix('idle', animations[i]);
			notes.animation.play('idle');
			//showNotes = notes.visible;
			notes.scale.set(0.8, 0.8);
			notes.x += 700;
			notes.antialiasing = ClientPrefs.globalAntialiasing;
			grpNote.add(notes);
				
			var newShader:ColorSwap = new ColorSwap();
			notes.shader = newShader.shader;
			newShader.hue = ClientPrefs.arrowHSV[i][0] / 360;
			newShader.saturation = ClientPrefs.arrowHSV[i][1] / 100;
			newShader.brightness = ClientPrefs.arrowHSV[i][2] / 100;
		}
	}
}