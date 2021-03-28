//---------------------------------------------------------------------------------------
//	Class:	X2EventListener_AutopsyRequired
//	Authors: Iridar, BStar and RustyDios
//	
//	Created some time before	19/01/21	00:00
//	Last Edited by RustyDios	29/01/21	03:45
//
//	Purpose: what this mod is designed for, blocking the YAF1 UI if autopsy/conditions are not met
//	Has all the info block logic, listener itself only registered in tactical
//
//	Also calls for obfuscation on my Unit Flag Extended Mod
//
//---------------------------------------------------------------------------------------
class X2EventListener_AutopsyRequired extends X2EventListener config(AutopsyRequiredConfig);

struct YAF1_AutopsyRequirementStruct
{
	var name		AutopsyName;
	var array<name> CharacterTemplates;
};

var config array<YAF1_AutopsyRequirementStruct> YAF1_AutopsyRequirement;
var config name LostRequireAutopsyName;

var config bool bEnableLog, bAlwaysEncountersRequired, bAlwaysBlockEITooltips, bHideEITooltips, bAllowUIUnitFlagOverride;

var config int NumChosenEncountersRequired, NumRulerEncountersRequired;
var config EFactionInfluence RivalFactionInfluenceRequired;

var localized string m_strNoInfoAvailable_Required, m_strNoInfoAvailable_Encounters, m_strNoInfoAvailable_Faction;

//'config' here feels dirty hacky, but it um works.. so...
//was returning errors on compile for 'only access default variables'
//and then for mismatch in const out, when it was a localized string ... but both are strings ??
//either way, internal use only... but it um works.. so... 
var config string strBlockedReason;

//REGISTER THE TEMPLATES
static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(Create_YAF1_Autopsy());

	if (default.bAllowUIUnitFlagOverride)
	{
		Templates.AddItem(Create_UIUnitFlagExtended_Autopsy());
	}

	return Templates;
}

//CREATE THE LISTENER TEMPLATES
static function CHEventListenerTemplate Create_YAF1_Autopsy()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'X2EventListener_YAF1_Autopsy');

	Template.RegisterInTactical = true;
	Template.RegisterInStrategy = false;

	Template.AddCHEvent('YAF1_OverrideShowInfo', Autopsy_ListenerEventFunction, ELD_Immediate, 42);	//42 to run after other mods, like YAF1 colour profiles

	return Template;
}

static function CHEventListenerTemplate Create_UIUnitFlagExtended_Autopsy()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'X2EventListener_UIUnitFlagExtended_Autopsy');

	Template.RegisterInTactical = true;
	Template.RegisterInStrategy = false;

	Template.AddCHEvent('UIUnitFlag_OverrideShowInfo', Autopsy_ListenerEventFunction, ELD_Immediate); //50 to run at same time as parent

	return Template;
}

/*;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	// allow mods to change the show/hide behavior	
;	//	SENT FROM WOTCLootIndicator_Extended.UC
;	//			UI Unit Flag Extended
;	Tuple = new class'LWTuple';
;	Tuple.Id = 'UIUnitFlag_OverrideShowInfo';
;	Tuple.Data.Add(2);
;
;		// The targeted unit.
;	Tuple.Data[0].kind = LWTVObject;
;	Tuple.Data[0].o = Target;
;		// Whether the info should be available.
;	Tuple.Data[1].kind = LWTVBool;
;	Tuple.Data[1].b = true;
;
;	`XEVENTMGR.TriggerEvent('UIUnitFlag_OverrideShowInfo', Tuple);
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;*/

/*;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	// allow mods to change the show/hide behavior
;	//		SENT FROM YAF1_UIUNITINFO.UC
;	Tuple = new class'LWTuple';
;	Tuple.Id = 'YAF1_OverrideShowInfo';
;	Tuple.Data.Add(4);
;
;		// The targeted unit.
;	Tuple.Data[0].kind = LWTVObject;
;	Tuple.Data[0].o = Target;
;		// Whether the info should be available.
;	Tuple.Data[1].kind = LWTVBool;
;	Tuple.Data[1].b = XComGameState_Unit(Target) != none;
;		// What to show as a title description
;	Tuple.Data[2].kind = LWTVString;
;	Tuple.Data[2].s = XComGameState_Unit(Target) != none ? XComGameState_Unit(Target).GetName(eNameType_FullNick) : m_strNotAUnit;
;		// What to show as a reason
;	Tuple.Data[3].kind = LWTVString;
;	Tuple.Data[3].s = m_strNoInfoAvailable;
;
;	`XEVENTMGR.TriggerEvent('YAF1_OverrideShowInfo', Tuple);
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;*/

//CREATE THE ELR FUNCTION
static function EventListenerReturn Autopsy_ListenerEventFunction(Object EventData, Object EventSource, XComGameState NewGameState, Name Event, Object CallbackData)
{
	local LWTuple				Tuple;
	local XComGameState_Unit	TargetUnit;

	Tuple = LWTuple(EventData);

	`LOG("========== STARTING YAF1AR AUTOPSY CHECKING ==========", default.bEnableLog, 'YAF1_AutopsyRequired');

	//BAILOUT CONDITIONS
	if (Tuple == none)
	{
		`LOG("YAF1AR AUTOPSY CHECK RESULT : NO TUPLE ?!", default.bEnableLog, 'YAF1_AutopsyRequired');
		`LOG("========== FINISHED YAF1AR AUTOPSY CHECKING ==========", default.bEnableLog, 'YAF1_AutopsyRequired');
		return ELR_NoInterrupt;
	}
	
	//get the all important unit to check
	TargetUnit = XComGameState_Unit(Tuple.Data[0].o);

	//bailout for non-units ... for tabbing to a destructable
	if (TargetUnit == none)
	{
		`LOG("YAF1AR AUTOPSY CHECK RESULT : NOT A UNIT : SHOW F1 SCREEN IS:" @ Tuple.Data[1].b, default.bEnableLog, 'YAF1_AutopsyRequired');
		`LOG("========== FINISHED YAF1AR AUTOPSY CHECKING ==========", default.bEnableLog, 'YAF1_AutopsyRequired');
		return ELR_NoInterrupt;
	}

	//bailout for friendly units ... we know our own abilities ... this includes mind controlled units!
	if (TargetUnit.IsFriendlyToLocalPlayer())
	{
		if(Tuple.ID == 'YAF1_OverrideShowInfo')			{	Trigger_YAF1_AR_CheckEvent(TargetUnit, Tuple.Data[1].b, Tuple.Data[3].s);	}
		if(Tuple.ID == 'UIUnitFlag_OverrideShowInfo')	{	Trigger_YAF1_AR_CheckEvent(TargetUnit, Tuple.Data[1].b, "UIUNITFLAG");		}

		`LOG("YAF1AR AUTOPSY CHECK RESULT : FRIENDLY UNIT : SHOW F1 SCREEN IS:" @ Tuple.Data[1].b, default.bEnableLog, 'YAF1_AutopsyRequired');
		`LOG("========== FINISHED YAF1AR AUTOPSY CHECKING ==========", default.bEnableLog, 'YAF1_AutopsyRequired');
		return ELR_NoInterrupt;
	}

	//CHECK IF THIS ENEMY INFO IS BLOCKED	
	if (IsEnemyInfoBlocked(Tuple, TargetUnit))
	{
		//THIS IS ACTUALLY IF THE INFO SHOULD NOT SHOW, SO FALSE = NO INFO 
		//... WE ONLY GET THIS FAR IF THE 'CONDITIONS' ARE TRUE
		//... YES THIS MAKES SOME CONFUSING LOGIC !!
		Tuple.Data[1].b = false;
	}

	if(Tuple.ID == 'YAF1_OverrideShowInfo')			{	Trigger_YAF1_AR_CheckEvent(TargetUnit, Tuple.Data[1].b, Tuple.Data[3].s);	}
	if(Tuple.ID == 'UIUnitFlag_OverrideShowInfo')	{	Trigger_YAF1_AR_CheckEvent(TargetUnit, Tuple.Data[1].b, "UIUNITFLAG");		}

	`LOG("YAF1AR AUTOPSY CHECK RESULT : INFO CHECKED : SHOW F1 SCREEN IS:" @ Tuple.Data[1].b, default.bEnableLog, 'YAF1_AutopsyRequired');
	`LOG("========== FINISHED YAF1AR AUTOPSY CHECKING ==========", default.bEnableLog, 'YAF1_AutopsyRequired');

	return ELR_NoInterrupt;
}

//CHECK FUNCTION
static public function bool IsEnemyInfoBlocked(out LWTuple Tuple, const XComGameState_Unit TargetUnit)
{
	local YAF1_AutopsyRequirementStruct		AutopsyStruct;
	local XComGameState_AdventChosen		ChosenState;
	local name CharacterTemplateName;
	local bool bBlockChosen, bBlockAutopsy;

	//	LOCAL THE CHARACTER TEMPLATE NAME FOR SPEED DURING AUTOPSY CHECKING
	CharacterTemplateName = TargetUnit.GetMyTemplateName();

	`LOG("TARGET UNIT:" @TargetUnit.GetFullName() @": TEMPLATE :" @CharacterTemplateName, default.bEnableLog, 'YAF1_AutopsyRequired');

	//	FIRST WE CHECK FOR CHOSEN AS THEY HAVE THIER OWN SPECIAL FUNCTION TO RUN
	//	CHOSEN - Block F1 if the rival faction influence is below required AND/OR if the Chosen has not been encountered the required number of times
	if (TargetUnit.IsChosen())
	{
		`LOG("Target Unit is a Chosen!", default.bEnableLog, 'YAF1_AutopsyRequired');

		ChosenState = TargetUnit.GetChosenGameState();
		if (ChosenState != none)
		{
			bBlockChosen = CheckChosenInfoBlocked(ChosenState, default.strBlockedReason);
			if(Tuple.ID == 'YAF1_OverrideShowInfo')
			{
				Tuple.Data[3].s = default.strBlockedReason;
			}

			return bBlockChosen; // DON'T KEEP CHECKING - true or false depending on chosen function
		}		
		else 
		{
			`LOG("No Chosen State ?, FOXED ON F1!", default.bEnableLog, 'YAF1_AutopsyRequired');
			if(Tuple.ID == 'YAF1_OverrideShowInfo')
			{
				Tuple.Data[3].s = "";
			}
			//KEEP CHECKING ?
		}
	}

	//	THEN WE CHECK FOR RULERS NEXT SO THE ENCOUNTER SYSTEM CAN RUN ON MODDED UNITS IN THE AUTOPSY LIST - F'ING VIPER CHILDREN 2.0 MESSING UP THE CONFIGS/ORDER WITH THE SAME NAMES!
	//	RULERS - Block F1 if the Ruler was not encountered already
	//	Safeguard the `X2Helpers_DLC_Day60` call behind a DLCLoaded check, cuz we'd hard CTD otherwise, even though `bIsSpecial` is not supposed to be set for non-rulers.
	if (TargetUnit.bIsSpecial && IsDLCLoaded('DLC_2'))
	{
		`LOG("Target Unit is a Ruler!", default.bEnableLog, 'YAF1_AutopsyRequired');
		`LOG("Current Encounters:" @class'X2Helpers_DLC_Day60'.static.GetRulerNumAppearances(TargetUnit) @"/" @default.NumRulerEncountersRequired @": Required" , default.bEnableLog, 'YAF1_AutopsyRequired');
		
		if (class'X2Helpers_DLC_Day60'.static.GetRulerNumAppearances(TargetUnit) < default.NumRulerEncountersRequired )
		{
			//encounters not met	"ENCOUNTERS :x/y"
			`LOG("Current Num Encounters less than Required. BLOCKED F1.", default.bEnableLog, 'YAF1_AutopsyRequired');
			if(Tuple.ID == 'YAF1_OverrideShowInfo')
			{	
				Tuple.Data[3].s = default.m_strNoInfoAvailable_Encounters @class'X2Helpers_DLC_Day60'.static.GetRulerNumAppearances(TargetUnit) $"/" $default.NumRulerEncountersRequired;
			}
			return true; // DON'T KEEP CHECKING
		}
		else
		{
			`LOG("Required Num Encounters achieved. SHOWING F1.", default.bEnableLog, 'YAF1_AutopsyRequired');
			if(Tuple.ID == 'YAF1_OverrideShowInfo')
			{	
				Tuple.Data[3].s = "";
			}
			return false; // DON'T KEEP CHECKING
		}
	}

	//	NOW WE CHECK FOR ALL AUTOPSY CONFIGGED UNITS NEXT - THE NORMAL LIST
	//	STANDARD CHECK AGAINST UNIT AND AUTOPSY LIST
	foreach default.YAF1_AutopsyRequirement(AutopsyStruct)
	{
		if (AutopsyStruct.CharacterTemplates.Find(CharacterTemplateName) != INDEX_NONE)
		{
			`LOG("Found autopsy config for this unit :" @AutopsyStruct.AutopsyName, default.bEnableLog, 'YAF1_AutopsyRequired');

			if (!`XCOMHQ.IsTechResearched(AutopsyStruct.AutopsyName))
			{
				`LOG("Autopsy is NOT researched ... " , default.bEnableLog, 'YAF1_AutopsyRequired');
				bBlockAutopsy = true; // KEEP CHECKING TO HOPEFULLY FIND ANOTHER MATCH !!
			}
			else 
			{
				`LOG("Autopsy is researched, SHOWING F1.", default.bEnableLog, 'YAF1_AutopsyRequired');
				bBlockAutopsy = false;	//reset
				if(Tuple.ID == 'YAF1_OverrideShowInfo')
				{	
					Tuple.Data[3].s = "";
				}
				return false; // DON'T KEEP CHECKING, DON'T PROCCEED TO BLOCK STEP !
			}
		}
		//else	//else here LOGGED EVERY OTHER FAILED MATCH config entry line! Decided this log output is not needed
		//{
		//	//THIS IS ACTUALLY REALLY USEFUL AS THE SYSTEM CHECKS FOR -MULTIPLE- AUTOPSY REQUIREMENTS BY DEFAULT
		//	`LOG("Unit NOT found in THIS config entry, FOXED ON F1", default.bEnableLog, 'YAF1_AutopsyRequired');
		//}
	}

	//	PENULTIMATELY WE CHECK THE LOST TEAM AGAINST THE LOST AUTOPSY - IF WE GOT THIS FAR ITS EITHER LOST OR NOT SUPPORTED
	//	LOST - Block F1 if the unit is on the Lost team and Lost autopsy has not been performed yet
	//	EVERYTHING ON LOST TEAM GETS THIS TREATMENT BECAUSE IM NOT CONFIGURING FOR ALL THE LOST TEMPLATES
	//	WE DO THIS LAST SO THAT SPECIFIC UNITS ON LOST HAVE A CHANCE TO RETURN WITH DIRECT AUTOPSIES ABOVE -- F'ING BIO LOST MESSING THINGS UP BY NOT BEING ON THE RIGHT TEAM!
	if (TargetUnit.GetTeam() == eTeam_TheLost && default.LostRequireAutopsyName != '' )
	{
		`LOG("Target is on Lost Team:" @TargetUnit.GetMyTemplateName(),default.bEnableLog, 'YAF1_AutopsyRequired');

		if (!`XCOMHQ.IsTechResearched(default.LostRequireAutopsyName))
		{
			`LOG("Lost Autopsy :" @default.LostRequireAutopsyName @": NOT complete ..." , default.bEnableLog, 'YAF1_AutopsyRequired');
			bBlockAutopsy = true; // KEEP CHECKING ?
		}
		else
		{
			`LOG("Lost Autopsy :" @default.LostRequireAutopsyName @": complete, SHOWING F1." , default.bEnableLog, 'YAF1_AutopsyRequired');
			bBlockAutopsy = false;	//reset
			if(Tuple.ID == 'YAF1_OverrideShowInfo')
			{	
				Tuple.Data[3].s = "";
			}
			return false; // DON'T KEEP CHECKING, DON'T PROCCEED TO BLOCK STEP !
		}
	}

	//	OKAY SO WE CHECKED -EVERYTHING- AND GOT TO THIS POINT ... 
	if (bBlockAutopsy)
	{
		bBlockAutopsy = false;	//reset for safety

		//autopsy not met	"AUTOPSY REQUIRED"
		`LOG("BLOCK conditions met, BLOCKED F1.", default.bEnableLog, 'YAF1_AutopsyRequired');
		if(Tuple.ID == 'YAF1_OverrideShowInfo')
		{	
			Tuple.Data[3].s = default.m_strNoInfoAvailable_Required;
		}
		return true; //WE HAD AT LEAST ONE MATCH TO BLOCK AFTER CHECKING EVERYTHING
	}

	//	FINALLY WE EXIT OUT AS THE ENEMY MATCHES NOTHING BLOCKING IT ABOVE -- AND SAFETY FOR UNITS NOT SUPPORTED
	//	for whenever we have not met a check or condition and got to this point
	`LOG("NO blocking conditions met, SHOWING F1.", default.bEnableLog, 'YAF1_AutopsyRequired');
	bBlockAutopsy = false;	//reset
	if(Tuple.ID == 'YAF1_OverrideShowInfo')
	{	
		Tuple.Data[3].s = "";
	}
	return false;
}

//CHECK CHOSEN FUNCTION - SPLIT SO CHOSEN UI SCREENS CAN CALL IT CORRECTLY
static public function bool CheckChosenInfoBlocked(XComGameState_AdventChosen ChosenState, out string strReason)
{
	local XComGameState_ResistanceFaction	FactionState;

	FactionState = XComGameState_ResistanceFaction(`XCOMHISTORY.GetGameStateForObjectID(ChosenState.RivalFaction.ObjectID));
	if (FactionState != none)
	{
		`LOG("Begin Influence check ::  Current:" @int(FactionState.GetInfluence()) @":" @FactionState.GetInfluence(), default.bEnableLog, 'YAF1_AutopsyRequired');
		`LOG(" Cont Influence check :: Required:" @int(default.RivalFactionInfluenceRequired) @":" @default.RivalFactionInfluenceRequired, default.bEnableLog, 'YAF1_AutopsyRequired');

		if (FactionState.GetInfluence() < default.RivalFactionInfluenceRequired )
		{
			`LOG("Required influence NOT met ...", default.bEnableLog, 'YAF1_AutopsyRequired');
			`LOG("Num Encounters check :: Current:" @ChosenState.GetNumEncounters() @"/" @default.NumChosenEncountersRequired @": Required" , default.bEnableLog, 'YAF1_AutopsyRequired');

			if (default.NumChosenEncountersRequired > 0)
			{
				if (ChosenState.GetNumEncounters() < default.NumChosenEncountersRequired )
				{
					//encounters not met	"ENCOUNTERS :x/y"
					`LOG("Num Encounters is less than Required. BLOCKED F1.", default.bEnableLog, 'YAF1_AutopsyRequired');
					strReason = default.m_strNoInfoAvailable_Encounters @ChosenState.GetNumEncounters() $"/" $default.NumChosenEncountersRequired;
					return true;	// DONT KEEP CHECKING
				}
				else
				{
					`LOG("Required Num Encounters achieved. SHOWING F1.", default.bEnableLog, 'YAF1_AutopsyRequired');
					strReason = "";
					return false;	// DONT KEEP CHECKING
				}
			}

			`LOG("Num Encounters check. Skipped <= 0 ", default.bEnableLog, 'YAF1_AutopsyRequired');
			`LOG("Required influence NOT met. BLOCKED F1.", default.bEnableLog, 'YAF1_AutopsyRequired');

			//influence not met		"HUNT PROGRESS :x/y"
			strReason = default.m_strNoInfoAvailable_Faction @int(FactionState.GetInfluence()) $"/" $int(default.RivalFactionInfluenceRequired);
			return true;	// DONT KEEP CHECKING
		}
		else
		{
			`LOG("Required influence met ...", default.bEnableLog, 'YAF1_AutopsyRequired');

			if (default.NumChosenEncountersRequired > 0 && default.bAlwaysEncountersRequired)
			{
				`LOG("FORCE Num Encounters check :: Current:" @ChosenState.GetNumEncounters() @"/" @default.NumChosenEncountersRequired @": Required" , default.bEnableLog, 'YAF1_AutopsyRequired');

				if (ChosenState.GetNumEncounters() < default.NumChosenEncountersRequired )
				{
					//encounters not met	"ENCOUNTERS :x/y"
					`LOG("Num Encounters is less than Required. BLOCKED F1.", default.bEnableLog, 'YAF1_AutopsyRequired');
					strReason = default.m_strNoInfoAvailable_Encounters @ChosenState.GetNumEncounters() $"/" $default.NumChosenEncountersRequired;
					return true;	// DONT KEEP CHECKING
				}
				else
				{
					`LOG("Required Num Encounters achieved. SHOWING F1.", default.bEnableLog, 'YAF1_AutopsyRequired');
					strReason = "";
					return false;	// DONT KEEP CHECKING
				}
			}

			`LOG("FORCE Num Encounters check. Skipped <= 0 or not Required", default.bEnableLog, 'YAF1_AutopsyRequired');
			`LOG("Required influence met, SHOWING F1", default.bEnableLog, 'YAF1_AutopsyRequired');
		}
	}
	else
	{
		`LOG("No Rival Faction State ?, SHOWING F1", default.bEnableLog, 'YAF1_AutopsyRequired');
	}

	//Chosen info NOT blocked
	strReason = "";
	return false;
}		

//SEND OUT A POST CHECKS TUPLE FOR OTHER MODS
//MODS SHOULD USE THIS TO -CHECK- THE RESULTS OF THE FUNCTION ABOVE ... BUT NOT TO EDIT IT, AS THAT DOES NOTHING ANYWAY
static function Trigger_YAF1_AR_CheckEvent(XComGameState_Unit UnitState, bool bCheckResult, string strReasonResult)
{
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
}

/*
//EXAMPLE ELR FUNCTION USING THE ABOVE EVENT - ELD_Immediate - RegisterInTactical = true, RegisterInStrategy = false -
static function EventListenerReturn YAF1_AR_PostCheck_ELR(Object EventData, Object EventSource, XComGameState NewGameState, Name Event, Object CallbackData)
{
	local LWTuple				Tuple;
	local XComGameState_Unit	TargetUnit;
	local bool 					DoStuff;
	local string				Display;

	Tuple = LWTuple(EventData);
	
	//BAILOUT CONDITIONS
	if (Tuple == none )		{ return ELR_NoInterrupt;	}
	
	//get the all important details to check
	TargetUnit = XComGameState_Unit(Tuple.Data[0].o);
	DoStuff = Tuple.Data[1].b;		//false is to hide, true is to show

	//bailout for non-units ... 
	if (TargetUnit == none)	{ return ELR_NoInterrupt;	}

	if (!Dostuff)
	{
		Display = Tuple.Data[2].s;
		//`LOG("UNIT:" @Targetunit.GetMyTemplateName() @": INFO RESULT :" @DoStuff @": REASON :" @Display, default.bEnableLog, 'ModName');
		//Code for what to do if the info is hidden ?
	}
}
*/

//HELPER FUNC TO CHECK FOR DLC_2 && MODS ... ALIEN RULERS
static private function bool IsDLCLoaded(name DLCName)
{

	local XComOnlineEventMgr	EventManager;
	local int					Index;

	EventManager = `ONLINEEVENTMGR;

	for(Index = EventManager.GetNumDLC() - 1; Index >= 0; Index--)	
	{
		if(EventManager.GetDLCNames(Index) == DLCName)	
		{
			return true;
		}
	}
	return false;
}
