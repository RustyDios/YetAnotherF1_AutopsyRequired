THEY created an XCOM 2 Mod Project!

=======================================================================================================================================================
STEAM DESC      https://steamcommunity.com/sharedfiles/filedetails/?id=2377251739
=======================================================================================================================================================
[h1]What is this ?[/h1]
This mod is an extension to [url=https://steamcommunity.com/sharedfiles/filedetails/?id=934236622]RoboJumpers Yet Another F1[/url] that changes the mechanics behind the screens new information.
This mod locks this detailed information behind specific conditions –[i] mainly autopsies [/i]– meaning until you have researched the appropriate autopsy or met the specific conditions, the information will be "encrypted".
This is a throwback to how things worked back in XCOM: Enemy Unknown/Within ! With a touch of WotC ... :)

[h1]How it works[/h1]
When you open the YAF1 screen a series of checks are made against the unit. The mod checks for Friendly, Chosen Influence, Chosen Encounters, Ruler Encounters, All Config Autopsy Entries and finally for The Lost Team.
If the mod finds a reason to block the screen information it does. If it finds no reason to block the screen then it does nothing, this means it will do nothing for (mod-added) enemies not in the config.
It can also match with multiple Config Autopsy entries, so a unit can have -more than one- unlocking Autopsy. This is so that there can be some cross-over with similar (mod-added) enemies, like ABA Drones and Hectorxz Drones.
Any time the YAF1 screen info should be shown it will be, overriding any previous lockout condition.

[h3]Friendly units[/h3]
Friendly units are never obfuscated, this includes enemy units under mind control or hacked !

[h3]Base game enemies[/h3]
All base game enemies have their detailed information unlocked by their respective autopsies. 

[h3]Mod-added enemies[/h3]
If they have an autopsy, mod-added enemies will have their detailed information unlocked by their respective autopsy, if they are in the config.
If they don't have an autopsy, their information will usually be unlocked by the autopsy of the corpse they drop, decided in the config.
There are some exceptions, e.g. for enemies that don't drop corpses. 
[b][url=https://steamcommunity.com/workshop/filedetails/discussion/2377251739/3105763714506491097]Please see here for a full list of supported mods[/url][/b]

[h3]The Lost[/h3]
All enemies on The Lost [i]Team[/i] have their detailed information unlocked by [i]The Lost Autopsy[/i]. This autopsy can can be changed in the config.

[h3]The Chosen[/h3]
The Chosen have their detailed information unlocked after you have either (A) completed the Covert Action [i]Hunt Chosen - Part I[/i] or (B) encountered that specific Chosen 4 times in battle.
All Chosen Information screens have been updated by MCO to reflect this new detail. Please see screenshots above. This behaviour can be adjusted in the config.

[h3]Alien Rulers[/h3]
The Rulers have their detailed information unlocked after you have encountered them in battle once, so from the 2nd Encounter. While this mod supports the Alien Hunters DLC, it does not require it. 
This behaviour can be adjusted in the config.

[h1]Compatibility[/h1]
This mod should be compatible with any and all mods, including;[list]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2368109302] YAF1 Colour Profiles [/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=709499969] Show More Buff Details [/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=1183444470] Extended Information [/url]
[/list]
For the latter two the mod has config options for how to control the side-panel HUD tool-tips. The default setup is to hide them on the main HUD until [i]the conditions[/i] are met.
Basic Buff/Debuff information can still be viewed by using the YAF1 screen.
[list][*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2285967646] Unit Flag Extended [/url][/list]
This mod has config options to control the information this mod displays. Default is to hide the same stats YAF1 does.
Damage, aim, mobility, dodge, hack, will and psi are all hidden. Leaving HP, Defence, Shields and Armour ... until the unit autopsy is done.

[list][*]Has MCO's for the following UI screens; [b]UIChosenInfo[/b], [b]UIChosenReveal[/b], [b]UIChosenLevelUp[/b] and [b]UIChosenMissionSummary[/b].[/list]
These MCO's restrict the information on various Chosen screens, see screenshots.
I know of no other mods that override these screens, but the MCO's here are 'non-essential' and can all be commented out with a [b];[/b] in the [b]XComEngine.ini[/b] if required.

[b][url=https://steamcommunity.com/workshop/filedetails/discussion/2377251739/3105763714506491097] Please see here for a full list of supported mods[/url][/b]

[h1]Config[/h1]
The config file [b]XComAutopsyRequiredConfig.ini[/b] has plenty of options. You can decide how to treat side-panel HUD tool-tips, the faction level influence required to unlock the Chosen Information and the number of Encounters needed.
All enemies that require autopsy and their autopsy needed are also located here. An enemy can be in multiple Autopsy entries and the information will unlock if any one of them is complete.

[h1]Known Issues[/h1]
[olist]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=1127409511] Additional Icons [/url] and
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1630804593]Tactical Information Overhaul [/url]
Will by default display enemy stats above their health bar. If you want to keep that information "secret" until you've completed all the enemy autopsies, I suggest disabling the stats in those mods respective config options.
[/olist]
I've tested this as much as I'm able too, but please let me know if anything goes wrong. I'm only human. This was a HUGE project.

[h1]Thanks and Credits[/h1]
[b]BStar[/b] and [b]Iridar[/b] for writing the base code in this mod. I heavily adapted their working prototype for this release version.
[b]RoboJumper[/b] for coding help and for making YAF1 and adding a hook that made this mod possible, and teaching me about Tuples.
[b]MrNiceUK[/b] and [b]kdm2k6[/b] For the amazing help with the Extended Information/ tool-tips override.
[b]Veehementia[/b] for setting up most of the configuration for the base game enemies.
[b]dotvhs[/b] for the beautiful preview image.
... and all the super helpful support from the XCOM2 Modders Discord !

~ Enjoy [b]!![/b] and please buy me a [url=https://www.buymeacoffee.com/RustyDios] Cuppa Tea [/url]
=======================================================================================================================================================
=======================================================================================================================================================
SUPPORTED MODS THREAD       https://steamcommunity.com/workshop/filedetails/discussion/2377251739/3105763714506491097
=======================================================================================================================================================
=======================================================================================================================================================
This is a list of the mods supported by default in the YAF1AR, original list compiled by [b]Bstar[/b];

[h1]Supported DLC/ Mods[/h1]

[h3]'By Firaxis'[/h3]
[url=https://store.steampowered.com/app/433090/XCOM_2_Alien_Hunters/?curator_clanid=9756027] Alien Hunters DLC[/url]
The Rulers work on the Encounter system instead of an autopsy. The default setup is info revealed on the 2nd Encounter. The Viper NeoNates are added to the Viper Autopsy.

[url=https://store.steampowered.com/app/433091/XCOM_2_Shens_Last_Gift/] Shens Last Gift DLC[/url]
This DLC adds no new autopsies. Therefore, all enemies added by this DLC have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.	

[h3]by DerBK[/h3]	
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1126623381] A Better ADVENT: War of the Chosen[/url]	
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.
There are some crossovers for the ABA Chryssalids to use CX HIVE Autopsies.	
[b]Exceptions:[/b]	
[list]
     [*]Advent Drone: MEC Autopsy OR Standalone ADVENT Drones Autopsy
     [*]Wyvern : Viper Autopsy OR Standalone Flame Viper Autopsy
[/list]
	
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1481840594] ABA: Better DLC[/url]	
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.	

[h3]by CreativeXenos[/h3]	
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1658110374] Advent Field Training[/url]	
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.	
	
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1241956143] Advent General Revamp[/url]	
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.	
	
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1309465679] Advent Psi Ops[/url]	
This mod adds only one new autopsy for the Phase Drone. The other enemies added by this mod don't drop corpses and therefore can't be autopsied at all. Instead their detailed F1 info is unlocked by the Priest Autopsy.	
	
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1958853933] Advent Purifier Revamp[/url]	
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.	
	
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1505294997] Armored Viper[/url]	
The enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info.	

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1142283405] Valentines Viper[/url]	
The enemy added by this mod doesn't have it's own autopsy. Therefore, the enemy added by this mod has its detailed F1 info unlocked by the base game autopsy corresponding to the corpse it drops.	

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1472606636] Berserker Omega[/url]	
The enemy added by this mod doesn't have it's own autopsy. Therefore, the enemy added by this mod has its detailed F1 info unlocked by the base game autopsy corresponding to the corpse it drops.	
	
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1731235406] Bio Division 2.0[/url]	
Some of the enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info.	
[b]Exceptions:[/b]
[list]
     [*]Bio Trooper:	    ADVENT Trooper Autopsy
     [*]Bio Captain:	    ADVENT Captain Autopsy
     [*]Bio MEC:	        MEC Autopsy
     [*]Bio MEC Trooper:	MEC Autopsy
     [*]Bio Lost:	        The Lost Autopsy
     [*]Bio Lost Bleeder:	The Lost Autopsy
[/list]
	
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1184533147] Celatid Alien[/url]	
The enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info.	
	
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1347419249] Children Of The King[/url]	
Since you can only encounter each of the Children once, their detailed F1 info will be unlocked by the Viper autopsy. The same goes for the Hatchlings and Frostlings.	

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=2205934483] Children Of The King 2.0[/url]	
Since the Children are now Rulers their detailed F1 info will be unlocked as per the Ruler Encounter system. 
Hatchlings and Frostlings will be unlocked by the Viper autopsy.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1125183947] CreativeXenos Archons[/url]	
The enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info.	
	
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1502891114] EU Berserker[/url]	
The enemy added by this mod doesn't have it's own autopsy. Therefore, the enemy added by this mod has its detailed F1 info unlocked by the base game autopsy corresponding to the corpse it drops.	
	
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1779437601] Even More Robots[/url]	
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.	
[b]Exceptions:[/b]	
[list]
     [*]Security Bit:	    MEC Autopsy OR Standalone ADVENT Drones Autopsy
     [*]Adv Security Bit:	MEC Autopsy OR Standalone ADVENT Drones Autopsy
     [*]Sectopod Hunter:	Sectopod Autopsy
[/list]

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1386027774] Sectoid Abductor[/url]	
The enemy added by this mod doesn't have it's own autopsy. Therefore, the enemy added by this mod has its detailed F1 info unlocked by the base game autopsy corresponding to the corpse it drops	
	
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1918499687] The Hive[/url]	
Most enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info.
The CX Drone can also use the base game autopsy, and there are crossovers for the ABA Chryssalids too.
The CX Queen is a Ruler and as such will unlock per the Ruler Encounter system.
[b]Exceptions:[/b]
[list]
    [*]Shrieker:   	Chryssalid Autopsy
    [*]Infector:	Chryssalid Autopsy
    [*]Swarmer: 	Ripper Autopsy
[/list]

[h3]by Claus[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=2094672450] Custodian Pack[/url]
Most enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info.
[b]Exceptions:[/b]
[list]
     [*]ADVENT Courier: ADVENT Trooper Autopsy
[/list]

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1229048071] Pathfinders[/url]
The enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1927497195] Purge Priests[/url]
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=2182049731] Muton Hunters[/url] && [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2435857055] Muton Harriers[/url]
These mods add one new 'autopsy'. I grouped all of Claus' Mutons to this research, The BlackFlame Grenade. You might need to adjust the config if using only one.

[h3]by hectorxz[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1564970426] Advent Drone[/url]
The enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info.
This autopsy can also be used for the ABA Drones, and EMR Security Bits.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1563023889] Alien Elite Pack[/url]
This mod adds one new autopsy for the Muton Elite. This autopsy can also be used for Alpha's Muton Pack and AHW Muton Elites.
The other enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.
The same goes for the standalone versions of the included enemies.

[h3]by ReshiKillim[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1968720910] A Harder War: Advanced Aliens[/url]
The Muton Elites in this pack can unlock using the Alien Elite Pack Muton Elite Autopsy OR by the base game Mutons.
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1941763677] A Harder War: The Fanatics[/url]
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.

[h3]by Farkyrie[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1139726548] ADVENT Duelist[/url]
The enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1126501968] ADVENT Sniper[/url]
The enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info.

[h3]by Wilko[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1177720393] Advent Medic[/url]
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.

[h3]by Ashlynne_Lee[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1144417938] ADVENT Warlock[/url]
The enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info. The Warlock Autopsy also unlocks detailed information about their raised zombies.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1160638944] Flame Viper[/url]
The enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info. This autopsy can also be used for the ABA Wyvern.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=2280597326] Black Ice Codex[/url]
The enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info. Can also be unlocked by normal Codex Autopsy.

[h3]by LeaderEnemyBoss[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1311300228] LEB's Lategame Enemies[/url]
This mod adds one new autopsy for the Riftkeeper. The Venator added by this mod has its detailed F1 info unlocked by the base game autopsy corresponding to the corpse it drops.

[h3]by Deadput[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1783020206] Forged Sectopod[/url]
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsy corresponding to the corpse it drops.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1972274071] Standalone Muton Centurian [/url]
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsy corresponding to the corpse it drops.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1830279289] Advent Hunter Restoration[/url]
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game Stunlancer autopsy, corresponding to the corpses they drop.

[h3]by Alpha115[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1555120968] Muton Enemy Pack[/url]
The Muton Elites in this pack can unlock using the Alien Elite Pack Muton Elite Autopsy OR by the base game Mutons.
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.

=======================================================================================================================================================
=======================================================================================================================================================
SUPPORTED MODS THREAD 'LW' UPDATE      https://steamcommunity.com/workshop/filedetails/discussion/2377251739/3105763714506491097
=======================================================================================================================================================
=======================================================================================================================================================
This is a continuation list of the mods supported by default in the YAF1AR, original list compiled by [b]InterventoR[/b];

[h1] MORE Supported DLC/ Mods[/h1]

[h3]by Kiruka[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=2299170518] MOD Jam[/url]
This mod adds autopsies that affect several other mods, namely Bio Division 2.0 and CryoPriests. These enemies have additional autopsy unlocks.

[h3]By LWOTC Dev Team/Pavonis[/h3]
[url=https://www.nexusmods.com/xcom2/mods/757/] LWOTC[/url]
This 'mod' adds tons of new enemies. All enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.

[h3]by Deadput/LW[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1561740813] CryoPriests[/url]
This mods enemies are either unlocked through the Priest autopsy or by thier ModJam Autopsy

[h3]by Malek Deneith/LW[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1191707123] ADVENT Sentry[/url]
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.

[h3]by ACE[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=2072810074] ADVENT DeathTrooper[/url]
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.

[h3]by ReshiKillim[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=2204634458] A Harder War: Requiem of Man[/url]
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.

[h3]by Frizzeldian[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1910686840] MEC Breacher[/url]
The enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info.

[h3]by Reality Machina[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1312508920] Salarians[/url]
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the base game autopsies corresponding to the corpses they drop.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1490033824] Krogans[/url]
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the Muton autopsy.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1391051898] Snaghelli[/url]
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the Spectre autopsy.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1318290914] Taurians[/url]
The enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1316359865] Asari Adepts[/url]
The enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1300588366] Synthoids[/url]
The enemies added by this mod have their own autopsies and these are used to unlock their detailed F1 info.

[h3]by Fireborn/Giuseppelli[/h3]
[url=https://steamcommunity.com/sharedfiles/filedetails/?id=1768418191] The Tank Mod[/url]
This mod adds no new autopsies. Therefore, all enemies added by this mod have their detailed F1 info unlocked by the Sectopod autopsy.

=======================================================================================================================================================
=======================================================================================================================================================
RECIEVED FROM BSTAR VIA DISCORD ON 19/01/21

INTITIAL MOD CODE CLEANED A LITTLE
INITIAL CONFIG CODE CLEANED A LITTLE

https://steamcommunity.com/sharedfiles/filedetails/?id=934236622 YAF1
https://steamcommunity.com/sharedfiles/filedetails/?id=2368109302 YAF1 Profiles

https://steamcommunity.com/sharedfiles/filedetails/?id=709499969 Show More Buff Details
https://steamcommunity.com/sharedfiles/filedetails/?id=1183444470 Ex INFO

base code by iridar and bstar
preview image by dotvhs
------------------------------
as well as the current MCO's there was a UIChosenEncountered.uc >> this seems to be the reveal on strategy screen and didn't need any adjusts
called from XComHQPresentationLayer >> lines 4597 ish 
simulated function UIChosenEncountered(XComGameState_AdventChosen ChosenState)
AND >> lines 5132 ish
function UIChosenRevealComplete()
and a UIChosenFragmentRecovered.uc >> this is the strategy screen on completion of a covert action 'hunt' and didn't need any adjusts
--------------------------
Added MCO's for CHOSEN Strategy Info Screen, Chosen Tactical Reveal, Chosen Level Up and Chosen Post Mission Summary
Changed Block Info Logic and Logs to make sense
Allowed the list to check multiple entries
Covered all clauses

Extracted Block info Chosen Section to own function for UI Screens to access
Added Localisation for UI's
extensive beta testing 

FIXED EXTENDED INFO TOOLTIPS WITH HELP FROM KDM2K6 AND MRNICEUK

Created a 'post check tuple' ... not sure it'll be useful at all ... 
==================================================================================
	local LWTuple	Tuple;

	Tuple = new class'LWTuple';
	Tuple.Id = 'YAF1_AR_PostCheck';
	Tuple.Data.Add(3);

		// used to confirm the target unit
	Tuple.Data[0].kind = LWTVObject;
	Tuple.Data[0].o = UnitState;
		// Whether the info is available.
	Tuple.Data[1].kind = LWTVBool;
	Tuple.Data[1].b = bCheckResult;
		// The reason it was blocked
	Tuple.Data[2].kind = LWTVString;
	Tuple.Data[2].s = strReasonResult;

	`XEVENTMGR.TriggerEvent('YAF1_AR_PostCheck', Tuple);

Sent in the event that this one responsed too ... 
